ActiveAdmin::Views::IndexAsTable::IndexTableFor::TableActions.class_eval do
  def item *args
    cl = args[2][:class]
    if cl.include? 'view_link'
      args[0] = '<span class="icon-eye"></span> '.html_safe + args[0]
      args[2][:class] += ' c-button c-button--ghost-info u-medium'
    elsif cl.include? 'edit_link'
      args[0] = '<span class="icon-pencil"></span> '.html_safe + args[0]
      args[2][:class] += ' c-button c-button--ghost-info u-medium'
    elsif cl.include? 'delete_link'
      args[0] = '<span class="icon-bin"></span> '.html_safe + args[0]
      args[2][:class] += ' c-button c-button--ghost-error u-medium'
    end
    text_node link_to *args
  end
end
