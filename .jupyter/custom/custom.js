define([
    'base/js/namespace',
    'base/js/events',
    'notebook/js/cell',
    'jquery',
    'codemirror/keymap/vim',
    'codemirror/addon/dialog/dialog'
    ],
    function(Jupyter, events, cell, $) {
        events.on("app_initialized.NotebookApp",
            function () {
                // Show line numbers in cells
                cell.Cell.options_default.cm_config.lineNumbers = true;

                // Wrap line
                cell.Cell.options_default.cm_config.lineWrapping = true;

                // Add Buttons
                Jupyter.toolbar.add_buttons_group([
                    {
                        'label'   : 'Restart & Run All',
                        'icon'    : 'fa-refresh',
                        'callback': function () {
                            Jupyter.toolbar.actions.call('jupyter-notebook:confirm-restart-kernel-and-run-all-cells')
                        }
                    },
                    {
                        'label'   : 'Restart & Clear Output',
                        'icon'    : 'fa-eraser',
                        'callback': function () {
                            Jupyter.toolbar.actions.call('jupyter-notebook:confirm-restart-kernel-and-clear-output')
                        }
                    },
                    // add more button here if needed.
                ]);

                // Hide header
                //Jupyter.toolbar.actions.call('jupyter-notebook:toggle-header')

                // Hide toolbar
                //Jupyter.toolbar.actions.call('jupyter-notebook:toggle-toolbar')

                Jupyter.keyboard_manager.edit_shortcuts.remove_shortcut('esc');
                cell.Cell.options_default.cm_config.vimMode = true;

                // codemirror dialog for cmdline and search
                $('head').append('<link rel="stylesheet" type="text/css" ' +
                    'href="/static/components/codemirror/addon/dialog/dialog.css">')
                $('head').append('<style type="text/css">' +
                    '.CodeMirror-dialog {opacity: 0.9 !important;}</style>');

                // avoid ipython command mode while in codemirror dialog
                var bind_events = cell.Cell.prototype.bind_events;
                cell.Cell.prototype.bind_events = function () {
                    bind_events.apply(this);
                    if (!this.code_mirror) return;
                    var that = this;
                    this.code_mirror.on('blur', function() {
                        if ($('.CodeMirror-dialog').length > 0)
                            that.events.trigger('edit_mode.Cell', {cell: that});
                    });
                }

            }
        );
    }
);

