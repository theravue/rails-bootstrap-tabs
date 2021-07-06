require 'rails'
require 'action_view'
require 'rails-bootstrap-tabs'

describe RailsBootstrapTabs::Renderers::TabsBootstrap4Renderer do
  let(:template) { mock_template }
  let(:renderer) { RailsBootstrapTabs::Renderers::TabsBootstrap4Renderer.new(template) }

  describe '#render_tabs_wrapper' do
    context 'nav_markup option is NOT nil' do
      let(:renderer) { RailsBootstrapTabs::Renderers::TabsBootstrap4Renderer.new(template, { nav_markup: true } ) }

      it 'renders nav wrapper' do
        expect(renderer.render_tabs_wrapper { '[tabs_content]' }).to eq '<nav class="nav nav-tabs">[tabs_content]</nav>'
      end
    end

    context 'nav_markup is nil' do
      it 'renders ul wrapper' do
        expect(renderer.render_tabs_wrapper { '[tabs_content]' }).to eq '<ul class="nav nav-tabs">[tabs_content]</ul>'
      end
    end
  end

  describe '#render_tab' do
    context 'nav_markup is NOT nil' do
      let(:renderer) { RailsBootstrapTabs::Renderers::TabsBootstrap4Renderer.new(template, { nav_markup: true } ) }

      it 'renders nav wrapper' do
        tab = double(options: { anchor: 'anch', link_class: 'lnk', active: true })
        expect(renderer.render_tab(tab) { '[title]' }).to eq '<a data-toggle="tab" class="nav-link active lnk" href="#anch">[title]</a>'
      end
    end

    context 'nav_markup is nil' do
      it 'renders tab' do
        tab = double(options: { anchor: 'anch', link_class: 'lnk', active: true })
        expect(renderer.render_tab(tab) { '[title]' }).to eq '<li class="nav-item"><a data-toggle="tab" class="nav-link active lnk" href="#anch">[title]</a></li>'
      end
    end
  end

  describe '#render_panes_wrapper' do
    it 'renders panes wrapper' do
      expect(renderer.render_panes_wrapper(content_class: 'cnt') { '[panes]' }).to eq '<div class="tab-content cnt">[panes]</div>'
    end
  end

  describe '#render_pane' do
    it 'renders pane' do
      tab = double(options: { anchor: 'anch', link_class: 'lnk', active: true })
      expect(renderer.render_pane(tab) { '[pane_content]' }).to eq '<div id="anch" class="tab-pane active" role="tabpanel">[pane_content]</div>'
    end
  end
end
