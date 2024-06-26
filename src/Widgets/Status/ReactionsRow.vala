// TODO: Move reaction logic from Accouncement.vala

public class Tuba.Widgets.ReactionsRow : Adw.Bin {
	Gtk.FlowBox reaction_box = new Gtk.FlowBox () {
		column_spacing = 6,
		row_spacing = 6,
		// Lower values leave space between items
		max_children_per_line = 100
	};

	construct {
		this.child = reaction_box;
	}

	public ReactionsRow (Gee.ArrayList<API.EmojiReaction> reactions) {
		foreach (API.EmojiReaction p in reactions) {
			if (p.count <= 0) continue;

			var badge_button = new Gtk.Button () {
				// translators: the variable is the emoji or its name if it's custom
				tooltip_text = _("React with %s").printf (p.name)
			};
			badge_button.set_accessible_role (Gtk.AccessibleRole.TOGGLE_BUTTON);
			badge_button.update_state (Gtk.AccessibleState.PRESSED, Gtk.AccessibleTristate.FALSE, -1);

			var badge = new Gtk.Box (Gtk.Orientation.HORIZONTAL, 6);

			if (p.url != null) {
				badge.append (new Widgets.Emoji (p.url));
			} else {
				badge.append (new Gtk.Label (p.name));
			}

			badge.append (new Gtk.Label (p.count.to_string ()));
			badge_button.child = badge;

			if (p.me == true) {
				badge_button.add_css_class ("accent");
				badge_button.update_state (Gtk.AccessibleState.PRESSED, Gtk.AccessibleTristate.TRUE, -1);
			}

			reaction_box.append (new Gtk.FlowBoxChild () {
				child = badge_button,
				focusable = false
			});
		}

		reaction_box.visible = reactions.size > 0;
	}
}
