print("F4 Menu loaded")
hook.Add("ShowSpare2", "F4Menu", function()
    local mainframe = vgui.Create("VoidUI.Frame")
    mainframe:SSetSize(ScrW() / 1.2, ScrH() / 1.2)
    mainframe:Center()
    mainframe:SetTitle("F4Menu")
    mainframe:MakePopup()
    local sidebar = mainframe:Add("VoidUI.Sidebar")
    local background = sidebar:Add("VoidUI.BackgroundPanel")
    background:Dock(FILL) -- takes up the whole space (from parent)
    background:DockMargin(15, 15, 15, 15) -- adds a margin of 15px to all sides
    background:SetTitle("Jobs", "Registered Jobs") --  sets the title and subtitle
    background:SetText("")
    local myGrid = background:Add("VoidUI.Grid")
    myGrid:Dock(FILL)
    myGrid:SDockMargin(20, 20, 20, 20)
    myGrid:SetColumns(4) -- Set how many columns are to be used!
    myGrid:SetHorizontalMargin(10)
    myGrid:SetVerticalMargin(10)
    for k, v in pairs(sTub.Jobs.Registered) do
        for job, tbl in pairs(v) do
            local itemPanel = vgui.Create("Panel")
            itemPanel:SetSize(300, 300)
            local card = vgui.Create("VoidUI.Card", itemPanel)
            card:Dock(LEFT)
            card:SSetWide(300)
            card:SDockMargin(5, 20, 20, 20)
            card:SetTitle(tostring(job), "")
            card:SetContent(tostring(tbl().description))
            card:SetAccent(Color(204, 120, 120)) -- title and button color
            card:SetGradient(Color(212, 59, 59), Color(71, 54, 218))
            card:SetFooter("Job: " .. tostring(job))
            card.button.DoClick = function()
                net.Start("CRP_SelectJob")
                net.WriteString(job)
                net.SendToServer()
            end

            myGrid:AddCell(itemPanel)
        end
    end

    sidebar:AddTab("Jobs", VoidUI.Icons.Board, background)
    sidebar:AddTab("Profile", VoidUI.Icons.User, "VoidUI.BackgroundPanel")
    sidebar:AddTab("Settings", VoidUI.Icons.Settings, "VoidUI.BackgroundPanel", true)
    return false
end)

hook.Add("PlayerBindPress", "f4Fix", function(ply, bind, pressd)
    --F4 Fix
    if bind == "gm_showspare2" then hook.Run("ShowSpare2", "test") end
end)