package com.dango_itimi.escape_game;

import com.dango_itimi.escape_game.event.Book;
import com.dango_itimi.escape_game.event.Event;
import com.dango_itimi.geom.Point;

enum Progress
{
	NO_HITAREA;
	NO_ENABLED_EVENT;
	UNFIRED(misfiredEvent:Event, misfiredSetting:Bool, itemLack:Bool, unfinishedAllRequiredEvents:Bool);
	NEXT(firedEvent:Event);
}

class BookReader
{
	private var book:Book;
	private var itemHolder:ItemHolder;

	public function new(book:Book, itemHolder:ItemHolder)
	{
		this.book = book;
		this.itemHolder = itemHolder;
	}

	//@return fired event
	public function progress(checkPosition:Point):Progress
	{
		var readingStory = book.readingStory;

		var hitArea = readingStory.getHitArea(checkPosition);
		if(hitArea == null)
			return Progress.NO_HITAREA;

		var event = readingStory.getEnabledEvent(hitArea);
		if(event == null)
			return Progress.NO_ENABLED_EVENT;

		var eventCondition = event.getCondision(itemHolder.set);
		switch(eventCondition){

			case EventCondition.MISFIRED(misfired, itemLack, unfinishedAllRequiredEvents):
				return Progress.UNFIRED(event, misfired, itemLack, unfinishedAllRequiredEvents);

			case EventCondition.FIRED:
			
				event.finish();
				if(!event.isBranched())
					readingStory.setNextPriorityInArea(hitArea);
				else
					book.branchReadingStory(event.nextStory);

				return Progress.NEXT(event);
		}
	}
}
