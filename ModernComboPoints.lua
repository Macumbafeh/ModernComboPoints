if select(2, UnitClass("player")) ~= "ROGUE" and select(2, UnitClass("player")) ~= "DRUID" then
	return
end

-- Combo frame and points
local ModernComboFrame = CreateFrame("Frame", "ModernComboFrame", UIParent)
ModernComboFrame:SetPoint("CENTER")
ModernComboFrame:SetWidth(100)
ModernComboFrame:SetHeight(25)
ModernComboFrame:SetMovable(true)
ModernComboFrame:EnableMouse(true)
ModernComboFrame:RegisterForDrag("LeftButton")
ModernComboFrame:SetScript("OnDragStart", function() ModernComboFrame:StartMoving() end)
ModernComboFrame:SetScript("OnDragStop", function() ModernComboFrame:StopMovingOrSizing() end)

local x = 0
local pointNumber = 0
local lastPointNumber = 0
local comboPoint = {}
local comboFont = {}
for i=1,5 do
	local frame = CreateFrame("Frame", "ModernComboPoint"..i, ModernComboFrame)
	frame:SetPoint("TOPLEFT", ModernComboFrame, x, 0)
	x = x + 100/5
	frame:SetWidth(100/5)
	frame:SetHeight(25)
	local frameFont = frame:CreateFontString("ModernComboFont"..i, "ARTWORK", "GameFontNormal")
	frameFont:SetPoint("CENTER", frame, 0, 0)
	frameFont:SetFont("Fonts\\FRIZQT__.TTF", 18, "THICKOUTLINE")
	frameFont:SetTextColor(1, 0, 0)
	frameFont:SetText(i)
	frame:Hide()
	comboPoint[i] = frame
	comboFont[i] = frameFont
end

-- Settings
local modernComboSettings = {}
modernComboSettings.panel = CreateFrame("Frame", "ModernComboSettingsPanel", UIParent)
modernComboSettings.panel.name = "ModernComboPoints"
InterfaceOptions_AddCategory(modernComboSettings.panel)
local SettingsTitle = ModernComboSettingsPanel:CreateFontString(nil, "ARTWORK", "GameFontNormal")
SettingsTitle:SetPoint("TOPLEFT", ModernComboSettingsPanel, 15, -15)
SettingsTitle:SetFont("Fonts\\FRIZQT__.TTF", 17)
SettingsTitle:SetJustifyH("LEFT")
SettingsTitle:SetText("ModernComboPoints")
local SettingsGeneralTitle = ModernComboSettingsPanel:CreateFontString(nil, "ARTWORK", "GameFontNormal")
SettingsGeneralTitle:SetPoint("TOPLEFT", ModernComboSettingsPanel, 15, -40)
SettingsGeneralTitle:SetFont("Fonts\\FRIZQT__.TTF", 10)
SettingsGeneralTitle:SetJustifyH("LEFT")
SettingsGeneralTitle:SetTextColor(1, 1, 1)
SettingsGeneralTitle:SetText("General settings")

local SettingsEnableButton = CreateFrame("CheckButton", nil, ModernComboSettingsPanel, "InterfaceOptionsCheckButtonTemplate")
SettingsEnableButton:SetPoint("TOPLEFT", ModernComboSettingsPanel, 25, -60)
SettingsEnableButton:SetHitRectInsets(0, -45, 0, 0)
SettingsEnableButton:SetWidth(25)
SettingsEnableButton:SetHeight(25)
SettingsEnableButton:SetScript("OnClick", function()
	if SettingsEnableButton:GetChecked() then
		modernComboSavedSettings[1] = 1
		if not ModernComboFrame:IsShown() then
			ModernComboFrame:Show()
		end
	else
		modernComboSavedSettings[1] = 0
		if ModernComboFrame:IsShown() then
			ModernComboFrame:Hide()
		end
	end
end)
local SettingsEnableFont = ModernComboSettingsPanel:CreateFontString(nil, "ARTWORK", "GameFontNormal")
SettingsEnableFont:SetPoint("TOPLEFT", ModernComboSettingsPanel, 50, -65)
SettingsEnableFont:SetFont("Fonts\\FRIZQT__.TTF", 13)
SettingsEnableFont:SetJustifyH("LEFT")
SettingsEnableFont:SetTextColor(1, 1, 1)
SettingsEnableFont:SetText("Enable")

local SettingsLockButton = CreateFrame("CheckButton", nil, ModernComboSettingsPanel, "InterfaceOptionsCheckButtonTemplate")
SettingsLockButton:SetPoint("TOPLEFT", ModernComboSettingsPanel, 25, -90)
SettingsLockButton:SetHitRectInsets(0, -90, 0, 0)
SettingsLockButton:SetWidth(25)
SettingsLockButton:SetHeight(25)
SettingsLockButton:SetScript("OnClick", function()
	if SettingsLockButton:GetChecked() then
		modernComboSavedSettings[2] = 1
		ModernComboFrame:SetScript("OnDragStart", nil)
		ModernComboFrame:SetScript("OnDragStop", nil)
	else
		modernComboSavedSettings[2] = 0
		ModernComboFrame:SetScript("OnDragStart", function(self, button) ModernComboFrame:StartMoving() end)
		ModernComboFrame:SetScript("OnDragStop", function(self, button) ModernComboFrame:StopMovingOrSizing() end)
		ModernComboFrame:EnableMouse(true)
	end
end)
local SettingsLockFont = ModernComboSettingsPanel:CreateFontString(nil, "ARTWORK", "GameFontNormal")
SettingsLockFont:SetPoint("TOPLEFT", ModernComboSettingsPanel, 50, -95)
SettingsLockFont:SetFont("Fonts\\FRIZQT__.TTF", 13)
SettingsLockFont:SetJustifyH("LEFT")
SettingsLockFont:SetTextColor(1, 1, 1)
SettingsLockFont:SetText("Lock position")

local SettingsHideComboButton = CreateFrame("CheckButton", nil, ModernComboSettingsPanel, "InterfaceOptionsCheckButtonTemplate")
SettingsHideComboButton:SetPoint("TOPLEFT", ModernComboSettingsPanel, 25, -120)
SettingsHideComboButton:SetHitRectInsets(0, -120, 0, 0)
SettingsHideComboButton:SetWidth(25)
SettingsHideComboButton:SetHeight(25)
SettingsHideComboButton:SetScript("OnClick", function()
	if SettingsHideComboButton:GetChecked() then
		modernComboSavedSettings[3] = 1
		ComboFrame:UnregisterAllEvents()
		ComboFrame:Hide()
	else
		modernComboSavedSettings[3] = 0
		ComboFrame:RegisterEvent("PLAYER_TARGET_CHANGED")
		ComboFrame:RegisterEvent("PLAYER_COMBO_POINTS")
		ComboFrame:Show()
	end
end)
local SettingsHideComboFont = ModernComboSettingsPanel:CreateFontString(nil, "ARTWORK", "GameFontNormal")
SettingsHideComboFont:SetPoint("TOPLEFT", ModernComboSettingsPanel, 50, -120)
SettingsHideComboFont:SetFont("Fonts\\FRIZQT__.TTF", 13)
SettingsHideComboFont:SetJustifyH("LEFT")
SettingsHideComboFont:SetTextColor(1, 1, 1)
SettingsHideComboFont:SetText("Hide the original\ncombo frame")

local SettingsWidthFont = ModernComboSettingsPanel:CreateFontString(nil, "ARTWORK", "GameFontNormal")
SettingsWidthFont:SetPoint("TOPLEFT", ModernComboSettingsPanel, 210, -50)
SettingsWidthFont:SetFont("Fonts\\FRIZQT__.TTF", 13)
SettingsWidthFont:SetJustifyH("LEFT")
SettingsWidthFont:SetText("Combo frame width")
local SettingsWidthSlider = CreateFrame("Slider", "SettingsWidthSlider", ModernComboSettingsPanel, "OptionsSliderTemplate")
SettingsWidthSlider:ClearAllPoints()
SettingsWidthSlider:SetPoint("TOPLEFT", 200, -65)
SettingsWidthSlider:SetMinMaxValues(0, 14)
SettingsWidthSlider:SetWidth(150)
SettingsWidthSliderLow:SetText(" |cffffffff60")
SettingsWidthSliderHigh:SetText("|cffffffff200 ")
SettingsWidthSlider:SetValueStep(1)
SettingsWidthSlider:SetHitRectInsets(0, 0, -5, -5)
SettingsWidthSlider:SetScript("OnMouseUp", function(self, button)
	if SettingsWidthSlider:GetValue() > 0 then
		modernComboSavedSettings[4] = 60 + SettingsWidthSlider:GetValue() * 10
	else
		modernComboSavedSettings[4] = 60
	end
	ModernComboFrame:SetWidth(modernComboSavedSettings[4])
	x = 0
	for i=1,5 do
		comboPoint[i]:SetPoint("TOPLEFT", ModernComboFrame, x, 0)
		x = x + modernComboSavedSettings[4] / 5
		comboPoint[i]:SetWidth(modernComboSavedSettings[4] / 5)
	end
end)
SettingsWidthSlider:SetScript("OnValueChanged", function()
	if SettingsWidthSlider:GetValue() > 0 then
		modernComboSavedSettings[4] = 60 + SettingsWidthSlider:GetValue() * 10
	else
		modernComboSavedSettings[4] = 60
	end
	ModernComboFrame:SetWidth(modernComboSavedSettings[4])
	x = 0
	for i=1,5 do
		comboPoint[i]:SetPoint("TOPLEFT", ModernComboFrame, x, 0)
		x = x + modernComboSavedSettings[4] / 5
		comboPoint[i]:SetWidth(modernComboSavedSettings[4] / 5)
	end
	GameTooltip:SetOwner(SettingsWidthSlider, "ANCHOR_TOP", 120, 20)
	GameTooltip:SetText("Width: "..modernComboSavedSettings[4])
	GameTooltip:Show()
	GameTooltip:FadeOut()
end)
SettingsWidthSlider:SetScript("OnEnter", function()
	if SettingsWidthSlider:GetValue() > 0 then
		modernComboSavedSettings[4] = 60 + SettingsWidthSlider:GetValue() * 10
	else
		modernComboSavedSettings[4] = 60
	end
	ModernComboFrame:SetWidth(modernComboSavedSettings[4])
	x = 0
	for i=1,5 do
		comboPoint[i]:SetPoint("TOPLEFT", ModernComboFrame, x, 0)
		x = x + modernComboSavedSettings[4] / 5
		comboPoint[i]:SetWidth(modernComboSavedSettings[4] / 5)
		comboPoint[i]:Show()
		comboPoint[i]:SetAlpha(1)
	end
	GameTooltip:SetOwner(SettingsWidthSlider, "ANCHOR_TOP", 120, 20)
	GameTooltip:SetText("Width: "..modernComboSavedSettings[4])
	GameTooltip:Show()
	GameTooltip:FadeOut()
end)
SettingsWidthSlider:SetScript("OnLeave", function()
	pointNumber = GetComboPoints()
	for i=1,5 do
		if i == pointNumber then
			comboPoint[i]:Show()
		else
			comboPoint[i]:Hide()
		end
	end
end)

local SettingsFontSizeFont = ModernComboSettingsPanel:CreateFontString(nil, "ARTWORK", "GameFontNormal")
SettingsFontSizeFont:SetPoint("TOPLEFT", ModernComboSettingsPanel, 245, -105)
SettingsFontSizeFont:SetFont("Fonts\\FRIZQT__.TTF", 13)
SettingsFontSizeFont:SetJustifyH("LEFT")
SettingsFontSizeFont:SetText("Font size")
local SettingsFontSizeSlider = CreateFrame("Slider", "SettingsFontSizeSlider", ModernComboSettingsPanel, "OptionsSliderTemplate")
SettingsFontSizeSlider:ClearAllPoints()
SettingsFontSizeSlider:SetPoint("TOPLEFT", 200, -120)
SettingsFontSizeSlider:SetMinMaxValues(0, 10)
SettingsFontSizeSlider:SetWidth(150)
SettingsFontSizeSliderLow:SetText(" |cffffffff12")
SettingsFontSizeSliderHigh:SetText("|cffffffff32 ")
SettingsFontSizeSlider:SetValueStep(1)
SettingsFontSizeSlider:SetHitRectInsets(0, 0, -5, -5)
SettingsFontSizeSlider:SetScript("OnMouseUp", function(self, button)
	if SettingsFontSizeSlider:GetValue() > 0 then
		modernComboSavedSettings[5] = 12 + SettingsFontSizeSlider:GetValue() * 2
	else
		modernComboSavedSettings[5] = 12
	end
	for i=1,5 do
		comboFont[i]:SetFont("Fonts\\FRIZQT__.TTF", modernComboSavedSettings[5], "THICKOUTLINE")
	end
end)
SettingsFontSizeSlider:SetScript("OnValueChanged", function()
	if SettingsFontSizeSlider:GetValue() > 0 then
		modernComboSavedSettings[5] = 12 + SettingsFontSizeSlider:GetValue() * 2
	else
		modernComboSavedSettings[5] = 12
	end
	for i=1,5 do
		comboFont[i]:SetFont("Fonts\\FRIZQT__.TTF", modernComboSavedSettings[5], "THICKOUTLINE")
	end
	GameTooltip:SetOwner(SettingsFontSizeSlider, "ANCHOR_TOP", 120, 20)
	GameTooltip:SetText("Font size: "..modernComboSavedSettings[5])
	GameTooltip:Show()
	GameTooltip:FadeOut()
end)
SettingsFontSizeSlider:SetScript("OnEnter", function()
	if SettingsFontSizeSlider:GetValue() > 0 then
		modernComboSavedSettings[5] = 12 + SettingsFontSizeSlider:GetValue() * 2
	else
		modernComboSavedSettings[5] = 12
	end
	for i=1,5 do
		comboFont[i]:SetFont("Fonts\\FRIZQT__.TTF", modernComboSavedSettings[5], "THICKOUTLINE")
		comboPoint[i]:Show()
		comboPoint[i]:SetAlpha(1)
	end
	GameTooltip:SetOwner(SettingsFontSizeSlider, "ANCHOR_TOP", 120, 20)
	GameTooltip:SetText("Font size: "..modernComboSavedSettings[5])
	GameTooltip:Show()
	GameTooltip:FadeOut()
end)
SettingsFontSizeSlider:SetScript("OnLeave", function()
	pointNumber = GetComboPoints()
	for i=1,5 do
		if i == pointNumber then
			comboPoint[i]:Show()
		else
			comboPoint[i]:Hide()
		end
	end
end)

local SettingsColorTitle = ModernComboSettingsPanel:CreateFontString(nil, "ARTWORK", "GameFontNormal")
SettingsColorTitle:SetPoint("TOPLEFT", ModernComboSettingsPanel, 15, -170)
SettingsColorTitle:SetFont("Fonts\\FRIZQT__.TTF", 10)
SettingsColorTitle:SetJustifyH("LEFT")
SettingsColorTitle:SetTextColor(1, 1, 1)
SettingsColorTitle:SetText("Color settings")

local SettingsRedColorFont = ModernComboSettingsPanel:CreateFontString(nil, "ARTWORK", "GameFontNormal")
SettingsRedColorFont:SetPoint("TOPLEFT", ModernComboSettingsPanel, 41, -190)
SettingsRedColorFont:SetFont("Fonts\\FRIZQT__.TTF", 13)
SettingsRedColorFont:SetJustifyH("LEFT")
SettingsRedColorFont:SetText("Red")
local SettingsRedLevelFont = ModernComboSettingsPanel:CreateFontString(nil, "ARTWORK", "GameFontNormal")
SettingsRedLevelFont:SetPoint("CENTER", ModernComboSettingsPanel, -138, -115)
SettingsRedLevelFont:SetFont("Fonts\\FRIZQT__.TTF", 13)
SettingsRedLevelFont:SetJustifyH("RIGHT")
SettingsRedLevelFont:SetText(255)
SettingsRedLevelFont:SetTextColor(1, 1, 1)
local SettingsRedColorSlider = CreateFrame("Slider", "SettingsRedColorSlider", ModernComboSettingsPanel, "OptionsSliderTemplate")
SettingsRedColorSlider:ClearAllPoints()
SettingsRedColorSlider:SetOrientation("VERTICAL")
SettingsRedColorSlider:SetThumbTexture("Interface\\Buttons\\UI-SliderBar-Button-Vertical")
SettingsRedColorSlider:SetPoint("TOPLEFT", 50, -210)
SettingsRedColorSlider:SetMinMaxValues(0, 255)
SettingsRedColorSlider:SetWidth(10)
SettingsRedColorSlider:SetHeight(100)
SettingsRedColorSliderLow:SetText("")
SettingsRedColorSliderHigh:SetText("")
SettingsRedColorSlider:SetValueStep(5)
SettingsRedColorSlider:SetValue(255)
SettingsRedColorSlider:SetHitRectInsets(-20, -20, -5, -5)
SettingsRedColorSlider:SetScript("OnMouseUp", function(self, button)
	modernComboSavedSettings[6] = SettingsRedColorSlider:GetValue()
	for i=1,5 do
		comboFont[i]:SetTextColor(modernComboSavedSettings[6]/255, modernComboSavedSettings[7]/255, modernComboSavedSettings[8]/255)
	end
end)
SettingsRedColorSlider:SetScript("OnValueChanged", function()
	modernComboSavedSettings[6] = SettingsRedColorSlider:GetValue()
	for i=1,5 do
		comboFont[i]:SetTextColor(modernComboSavedSettings[6]/255, modernComboSavedSettings[7]/255, modernComboSavedSettings[8]/255)
	end
	SettingsRedLevelFont:SetText(SettingsRedColorSlider:GetValue())
end)
SettingsRedColorSlider:SetScript("OnEnter", function()
	modernComboSavedSettings[6] = SettingsRedColorSlider:GetValue()
	for i=1,5 do
		comboFont[i]:SetTextColor(modernComboSavedSettings[6]/255, modernComboSavedSettings[7]/255, modernComboSavedSettings[8]/255)
		comboPoint[i]:Show()
		comboPoint[i]:SetAlpha(1)
	end
	SettingsRedLevelFont:SetText(SettingsRedColorSlider:GetValue())
end)
SettingsRedColorSlider:SetScript("OnLeave", function()
	pointNumber = GetComboPoints()
	for i=1,5 do
		if i == pointNumber then
			comboPoint[i]:Show()
		else
			comboPoint[i]:Hide()
		end
	end
end)

local SettingsGreenColorFont = ModernComboSettingsPanel:CreateFontString(nil, "ARTWORK", "GameFontNormal")
SettingsGreenColorFont:SetPoint("TOPLEFT", ModernComboSettingsPanel, 85, -190)
SettingsGreenColorFont:SetFont("Fonts\\FRIZQT__.TTF", 13)
SettingsGreenColorFont:SetJustifyH("LEFT")
SettingsGreenColorFont:SetText("Green")
local SettingsGreenLevelFont = ModernComboSettingsPanel:CreateFontString(nil, "ARTWORK", "GameFontNormal")
SettingsGreenLevelFont:SetPoint("CENTER", ModernComboSettingsPanel, -88, -115)
SettingsGreenLevelFont:SetFont("Fonts\\FRIZQT__.TTF", 13)
SettingsGreenLevelFont:SetJustifyH("RIGHT")
SettingsGreenLevelFont:SetText(0)
SettingsGreenLevelFont:SetTextColor(1, 1, 1)
local SettingsGreenColorSlider = CreateFrame("Slider", "SettingsGreenColorSlider", ModernComboSettingsPanel, "OptionsSliderTemplate")
SettingsGreenColorSlider:ClearAllPoints()
SettingsGreenColorSlider:SetOrientation("VERTICAL")
SettingsGreenColorSlider:SetThumbTexture("Interface\\Buttons\\UI-SliderBar-Button-Vertical")
SettingsGreenColorSlider:SetPoint("TOPLEFT", 100, -210)
SettingsGreenColorSlider:SetMinMaxValues(0, 255)
SettingsGreenColorSlider:SetWidth(10)
SettingsGreenColorSlider:SetHeight(100)
SettingsGreenColorSliderLow:SetText("")
SettingsGreenColorSliderHigh:SetText("")
SettingsGreenColorSlider:SetValueStep(5)
SettingsGreenColorSlider:SetValue(0)
SettingsGreenColorSlider:SetHitRectInsets(-20, -20, -5, -5)
SettingsGreenColorSlider:SetScript("OnMouseUp", function(self, button)
	modernComboSavedSettings[7] = SettingsGreenColorSlider:GetValue()
	for i=1,5 do
		comboFont[i]:SetTextColor(modernComboSavedSettings[6]/255, modernComboSavedSettings[7]/255, modernComboSavedSettings[8]/255)
	end
end)
SettingsGreenColorSlider:SetScript("OnValueChanged", function()
	modernComboSavedSettings[7] = SettingsGreenColorSlider:GetValue()
	for i=1,5 do
		comboFont[i]:SetTextColor(modernComboSavedSettings[6]/255, modernComboSavedSettings[7]/255, modernComboSavedSettings[8]/255)
	end
	SettingsGreenLevelFont:SetText(SettingsGreenColorSlider:GetValue())
end)
SettingsGreenColorSlider:SetScript("OnEnter", function()
	modernComboSavedSettings[7] = SettingsGreenColorSlider:GetValue()
	for i=1,5 do
		comboFont[i]:SetTextColor(modernComboSavedSettings[6]/255, modernComboSavedSettings[7]/255, modernComboSavedSettings[8]/255)
		comboPoint[i]:Show()
		comboPoint[i]:SetAlpha(1)
	end
	SettingsGreenLevelFont:SetText(SettingsGreenColorSlider:GetValue())
end)
SettingsGreenColorSlider:SetScript("OnLeave", function()
	pointNumber = GetComboPoints()
	for i=1,5 do
		if i == pointNumber then
			comboPoint[i]:Show()
		else
			comboPoint[i]:Hide()
		end
	end
end)

local SettingsBlueColorFont = ModernComboSettingsPanel:CreateFontString(nil, "ARTWORK", "GameFontNormal")
SettingsBlueColorFont:SetPoint("TOPLEFT", ModernComboSettingsPanel, 141, -190)
SettingsBlueColorFont:SetFont("Fonts\\FRIZQT__.TTF", 13)
SettingsBlueColorFont:SetJustifyH("LEFT")
SettingsBlueColorFont:SetText("Blue")
local SettingsBlueLevelFont = ModernComboSettingsPanel:CreateFontString(nil, "ARTWORK", "GameFontNormal")
SettingsBlueLevelFont:SetPoint("CENTER", ModernComboSettingsPanel, -38, -115)
SettingsBlueLevelFont:SetFont("Fonts\\FRIZQT__.TTF", 13)
SettingsBlueLevelFont:SetJustifyH("RIGHT")
SettingsBlueLevelFont:SetText(0)
SettingsBlueLevelFont:SetTextColor(1, 1, 1)
local SettingsBlueColorSlider = CreateFrame("Slider", "SettingsBlueColorSlider", ModernComboSettingsPanel, "OptionsSliderTemplate")
SettingsBlueColorSlider:ClearAllPoints()
SettingsBlueColorSlider:SetOrientation("VERTICAL")
SettingsBlueColorSlider:SetThumbTexture("Interface\\Buttons\\UI-SliderBar-Button-Vertical")
SettingsBlueColorSlider:SetPoint("TOPLEFT", 150, -210)
SettingsBlueColorSlider:SetMinMaxValues(0, 255)
SettingsBlueColorSlider:SetWidth(10)
SettingsBlueColorSlider:SetHeight(100)
SettingsBlueColorSliderLow:SetText("")
SettingsBlueColorSliderHigh:SetText("")
SettingsBlueColorSlider:SetValueStep(5)
SettingsBlueColorSlider:SetValue(0)
SettingsBlueColorSlider:SetHitRectInsets(-20, -20, -5, -5)
SettingsBlueColorSlider:SetScript("OnMouseUp", function(self, button)
	modernComboSavedSettings[8] = SettingsBlueColorSlider:GetValue()
	for i=1,5 do
		comboFont[i]:SetTextColor(modernComboSavedSettings[6]/255, modernComboSavedSettings[7]/255, modernComboSavedSettings[8]/255)
	end
end)
SettingsBlueColorSlider:SetScript("OnValueChanged", function()
	modernComboSavedSettings[8] = SettingsBlueColorSlider:GetValue()
	for i=1,5 do
		comboFont[i]:SetTextColor(modernComboSavedSettings[6]/255, modernComboSavedSettings[7]/255, modernComboSavedSettings[8]/255)
	end
	SettingsBlueLevelFont:SetText(SettingsBlueColorSlider:GetValue())
end)
SettingsBlueColorSlider:SetScript("OnEnter", function()
	modernComboSavedSettings[8] = SettingsBlueColorSlider:GetValue()
	for i=1,5 do
		comboFont[i]:SetTextColor(modernComboSavedSettings[6]/255, modernComboSavedSettings[7]/255, modernComboSavedSettings[8]/255)
		comboPoint[i]:Show()
		comboPoint[i]:SetAlpha(1)
	end
	SettingsBlueLevelFont:SetText(SettingsBlueColorSlider:GetValue())
end)
SettingsBlueColorSlider:SetScript("OnLeave", function()
	pointNumber = GetComboPoints()
	for i=1,5 do
		if i == pointNumber then
			comboPoint[i]:Show()
		else
			comboPoint[i]:Hide()
		end
	end
end)

-- OnEvents
local ModernComboEventFrame = CreateFrame("Frame")
ModernComboEventFrame:RegisterEvent("PLAYER_TARGET_CHANGED")
ModernComboEventFrame:RegisterEvent("PLAYER_COMBO_POINTS")
ModernComboEventFrame:RegisterEvent("PLAYER_LOGIN")
ModernComboEventFrame:SetScript("OnEvent", function(self, event, ...)
	if event == "PLAYER_LOGIN" then
		if modernComboSavedSettings == nil or #modernComboSavedSettings == 0 then
			modernComboSavedSettings = {}
			modernComboSavedSettings[1] = 1
			SettingsEnableButton:SetChecked()
			modernComboSavedSettings[2] = 0
			ModernComboFrame:SetScript("OnDragStart", function(self, button) ModernComboFrame:StartMoving() end)
			ModernComboFrame:SetScript("OnDragStop", function(self, button) ModernComboFrame:StopMovingOrSizing() end)
			ModernComboFrame:EnableMouse(true)
			modernComboSavedSettings[3] = 0
			modernComboSavedSettings[4] = 100
			SettingsWidthSlider:SetValue(4)
			modernComboSavedSettings[5] = 18
			SettingsFontSizeSlider:SetValue(3)
			modernComboSavedSettings[6] = 255
			modernComboSavedSettings[7] = 0
			modernComboSavedSettings[8] = 0
		else
			if modernComboSavedSettings[1] == 0 then
				ModernComboFrame:Hide()
			else
				SettingsEnableButton:SetChecked()
			end
			if modernComboSavedSettings[2] == 1 then
				SettingsLockButton:SetChecked()
				ModernComboFrame:SetScript("OnDragStart", nil)
				ModernComboFrame:SetScript("OnDragStop", nil)
			else
				ModernComboFrame:SetScript("OnDragStart", function(self, button) ModernComboFrame:StartMoving() end)
				ModernComboFrame:SetScript("OnDragStop", function(self, button) ModernComboFrame:StopMovingOrSizing() end)
				ModernComboFrame:EnableMouse(true)
			end
			if modernComboSavedSettings[3] == 1 then
				SettingsHideComboButton:SetChecked()
				ComboFrame:UnregisterAllEvents()
				ComboFrame:Hide()
			end
			ModernComboFrame:SetWidth(modernComboSavedSettings[4])
			SettingsWidthSlider:SetValue((modernComboSavedSettings[4] - 60) / 10)
			SettingsFontSizeSlider:SetValue((modernComboSavedSettings[5] - 12) / 2)
			x = 0
			for i=1,5 do
				comboPoint[i]:SetPoint("TOPLEFT", ModernComboFrame, x, 0)
				x = x + modernComboSavedSettings[4] / 5
				comboPoint[i]:SetWidth(modernComboSavedSettings[4] / 5)
				comboFont[i]:SetFont("Fonts\\FRIZQT__.TTF", modernComboSavedSettings[5], "THICKOUTLINE")
			end
			if not modernComboSavedSettings[6] then
				modernComboSavedSettings[6] = 255
			end
			if not modernComboSavedSettings[7] then
				modernComboSavedSettings[7] = 0
			end
			if not modernComboSavedSettings[8] then
				modernComboSavedSettings[8] = 0
			else
				SettingsRedColorSlider:SetValue(modernComboSavedSettings[6])
				SettingsRedLevelFont:SetText(modernComboSavedSettings[6])
				SettingsGreenColorSlider:SetValue(modernComboSavedSettings[7])
				SettingsGreenLevelFont:SetText(modernComboSavedSettings[7])
				SettingsBlueColorSlider:SetValue(modernComboSavedSettings[8])
				SettingsBlueLevelFont:SetText(modernComboSavedSettings[8])
				for i=1,5 do
					comboFont[i]:SetTextColor(modernComboSavedSettings[6]/255, modernComboSavedSettings[7]/255, modernComboSavedSettings[8]/255)
				end
			end
		end
		ModernComboEventFrame:UnregisterEvent("PLAYER_LOGIN")
	else
		pointNumber = GetComboPoints()
		for i=1,5 do
			if i ~= pointNumber and comboPoint[i]:GetAlpha() ~= 1 then
				comboPoint[i]:Hide()
			end
		end
		if pointNumber > 0 then
			for i=1,5 do
				if i == pointNumber and pointNumber ~= lastPointNumber then
					UIFrameFadeIn(comboPoint[i], 0.1)
				elseif i ~= pointNumber and comboPoint[i]:IsShown() then
					UIFrameFadeOut(comboPoint[i], 0.2)
				end
			end
		else
			for i=1,5 do
				if comboPoint[i]:IsShown() and comboPoint[i]:GetAlpha() == 1 then
					UIFrameFadeOut(comboPoint[i], 0.2)
				end
			end
		end
		lastPointNumber = pointNumber
	end
end)
ModernComboFrame:SetScript("OnEnter", function()
	for i=1,5 do
		comboPoint[i]:Show()
		comboPoint[i]:SetAlpha(1)
	end
end)
ModernComboFrame:SetScript("OnLeave", function()
	for i=1,5 do
		if i == GetComboPoints() then
			comboPoint[i]:Show()
		else
			comboPoint[i]:Hide()
		end
	end
end)