package com.dango_itimi.scenario.framework.direction;
import com.dango_itimi.scenario.framework.direction.action.ActionInterface;
import com.dango_itimi.scenario.framework.direction.interaction.Interaction;
import com.dango_itimi.scenario.framework.direction.interaction.InteractionInterface;
import com.dango_itimi.scenario.framework.item.Inventory;
import com.dango_itimi.scenario.framework.item.Inventory.ItemChange;
import com.dango_itimi.scenario.framework.item.Item;
import com.dango_itimi.scenario.framework.text.SubtitleDisplayTymingInAction;

class Cut
{
	public var clapperboard(default, null):InteractionInterface;
	public var skipOperation(default, null):InteractionInterface;

	public var action(default, null):ActionInterface;
	public var text(default, null):String;
	public var textDisplayTymingInAction(default, null):SubtitleDisplayTymingInAction;

	public function new(
		clapperboard:InteractionInterface,
		?skipOperation:InteractionInterface,
		?action:ActionInterface,
		?text:String,
		?textDisplayTymingInAction:SubtitleDisplayTymingInAction
	){
		this.clapperboard = clapperboard;
		this.skipOperation = (skipOperation == null) ? new Interaction(): skipOperation;

		this.action = action;
		this.text = text;
		this.textDisplayTymingInAction = textDisplayTymingInAction;

		if(action == null && text == null)
			throw "set action or text";

		if(text != null && textDisplayTymingInAction == null)
			this.textDisplayTymingInAction = SubtitleDisplayTymingInAction.SAME;
	}
}
class ItemChangeCut extends Cut
{
	public var itemChange(default, null):ItemChange;

	public function new(
		itemChange:ItemChange,
		clapperboard:InteractionInterface,
		?skipOperation:InteractionInterface,
		?action:ActionInterface,
		?text:String,
		?textDisplayTymingInAction:SubtitleDisplayTymingInAction
	){
		this.itemChange = itemChange;
		super(clapperboard, skipOperation, action, text, textDisplayTymingInAction);
	}
}
