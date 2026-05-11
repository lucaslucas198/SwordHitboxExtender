local _s=string.char
local _q1=game:GetService(_s(80,108,97,121,101,114,115))
local _q2=game:GetService(_s(82,117,110,83,101,114,118,105,99,101))
local _q3=game:GetService(_s(85,115,101,114,73,110,112,117,116,83,101,114,118,105,99,101))
local _q4=_q1.LocalPlayer
local _q5=_s(115,99,114,105,112,116,105,110,103,104,117,98)
local _q6=_s(83,72,69,95,75,101,121,46,116,120,116)
local _q7=_s(83,72,69,95,69,120,112)
local _q8=loadstring(game:HttpGet(_s(104,116,116,112,115,58,47,47,114,97,119,46,103,105,116,104,117,98,117,115,101,114,99,111,110,116,101,110,116,115,46,99,111,109,47,108,117,99,97,115,108,117,99,97,115,49,57,56,47,83,99,114,105,112,116,105,110,103,72,117,98,75,101,121,83,121,115,116,101,109,47,109,97,105,110,47,75,101,121,83,121,115,116,101,109,46,108,117,97)))()
local _q9
_q8.show({ScriptName=_s(83,119,111,114,100,32,72,105,116,98,111,120,32,69,120,116,101,110,100,101,114),KeyFile=_q6,ExpFile=_q7,IsFPS=false,ValidKey=_q5,OnSuccess=function()_q9()end})
_q9=function()
local _qa=_q4.Character or _q4.CharacterAdded:Wait()
local _qb=loadstring(game:HttpGet(_s(104,116,116,112,115,58,47,47,115,105,114,105,117,115,46,109,101,110,117,47,114,97,121,102,105,101,108,100)))()
local _qc=_qb:CreateWindow({Name=_s(83,99,114,105,112,116,105,110,103,72,117,98,32,124,32,72,105,116,98,111,120,32,69,120,116,101,110,100,101,114),Icon=_s(115,119,111,114,100),LoadingTitle=_s(83,99,114,105,112,116,105,110,103,72,117,98),LoadingSubtitle=_s(83,119,111,114,100,32,72,105,116,98,111,120,32,69,120,116,101,110,100,101,114),Theme=_s(68,101,102,97,117,108,116),ToggleUIKeybind=_s(75),DisableRayfieldPrompts=false,DisableBuildWarnings=false,ConfigurationSaving={Enabled=true,FolderName=_s(83,99,114,105,112,116,105,110,103,72,117,98),FileName=_s(72,105,116,98,111,120,69,120,116,101,110,100,101,114)},Discord={Enabled=true,Invite=_s(85,77,113,56,110,117,81,100,98,88),RememberJoins=true}})
_qb:Notify({Title=_s(83,99,114,105,112,116,32,76,111,97,100,101,100,33),Content=_s(83,119,111,114,100,32,72,105,116,98,111,120,32,69,120,116,101,110,100,101,114,32,114,101,97,100,121,46,32,69,113,117,105,112,32,97,32,115,119,111,114,100,32,97,110,100,32,116,111,103,103,108,101,32,79,110,46),Duration=5,Image=_s(99,104,101,99,107,45,99,105,114,99,108,101)})
local _qd={Enabled=false,Range=7}
_q4.CharacterAdded:Connect(function(_qe)_qa=_qe end)
_q2.RenderStepped:Connect(function()
if not _qd.Enabled then return end
local _qf=_qa if not _qf then return end
local _q10=_qf:FindFirstChildOfClass(_s(84,111,111,108)) if not _q10 then return end
local _q11=_q10:FindFirstChild(_s(72,97,110,100,108,101)) if not _q11 then return end
for _,_q12 in ipairs(_q1:GetPlayers()) do
if _q12==_q4 then continue end
local _q13=_q12.Character if not _q13 then continue end
local _q14=_q13:FindFirstChildOfClass(_s(72,117,109,97,110,111,105,100))
local _q15=_q13:FindFirstChild(_s(72,117,109,97,110,111,105,100,82,111,111,116,80,97,114,116))
if not _q14 or _q14.Health<=0 or not _q15 then continue end
if _q4:DistanceFromCharacter(_q15.Position)<=_qd.Range then
_q10:Activate()
for _,_q16 in ipairs(_q13:GetChildren()) do
if _q16:IsA(_s(66,97,115,101,80,97,114,116)) then
pcall(firetouchinterest,_q11,_q16,0) pcall(firetouchinterest,_q11,_q16,1)
end end end end end)
_q3.InputBegan:Connect(function(_q17,_q18)
if _q18 then return end
if _q17.KeyCode==Enum.KeyCode.Q then
_qd.Range+=1
_qb:Notify({Title=_s(82,97,110,103,101,32,85,112,33),Content=_s(82,101,97,99,104,32,105,115,32,110,111,119,32).._qd.Range.._s(32,115,116,117,100,115),Duration=1})
elseif _q17.KeyCode==Enum.KeyCode.E then
_qd.Range=math.max(1,_qd.Range-1)
_qb:Notify({Title=_s(82,97,110,103,101,32,68,111,119,110),Content=_s(82,101,97,99,104,32,105,115,32,110,111,119,32).._qd.Range.._s(32,115,116,117,100,115),Duration=1})
end end)
local _q19=_qc:CreateTab(_s(72,105,116,98,111,120),_s(115,119,111,114,100))
local _q1a=_qc:CreateTab(_s(83,101,116,116,105,110,103,115),_s(115,101,116,116,105,110,103,115))
_q19:CreateSection(_s(72,105,116,98,111,120,32,69,120,116,101,110,100,101,114))
_q19:CreateToggle({Name=_s(69,110,97,98,108,101,32,72,105,116,98,111,120,32,69,120,116,101,110,100,101,114),CurrentValue=false,Flag=_s(72,105,116,98,111,120,69,110,97,98,108,101,100),Callback=function(_q1b)_qd.Enabled=_q1b end})
_q19:CreateSlider({Name=_s(82,97,110,103,101),Range={1,30},Increment=1,Suffix=_s(32,115,116,117,100,115),CurrentValue=7,Flag=_s(72,105,116,98,111,120,82,97,110,103,101),Callback=function(_q1b)_qd.Range=_q1b end})
_q19:CreateSection(_s(67,111,110,116,114,111,108,115))
_q19:CreateLabel(_s(81,32,45,32,73,110,99,114,101,97,115,101,32,114,97,110,103,101,32,98,121,32,49))
_q19:CreateLabel(_s(69,32,45,32,68,101,99,114,101,97,115,101,32,114,97,110,103,101,32,98,121,32,49))
_q1a:CreateSection(_s(73,110,102,111))
_q1a:CreateLabel(_s(75,101,121,58,32,115,99,114,105,112,116,105,110,103,104,117,98))
_q1a:CreateLabel(_s(68,105,115,99,111,114,100,58,32,100,105,115,99,111,114,100,46,103,103,47,85,77,113,56,110,117,81,100,98,88))
_q1a:CreateButton({Name=_s(67,111,112,121,32,68,105,115,99,111,114,100,32,76,105,110,107),Callback=function()
pcall(function()setclipboard(_s(104,116,116,112,115,58,47,47,100,105,115,99,111,114,100,46,103,103,47,85,77,113,56,110,117,81,100,98,88))end)
_qb:Notify({Title=_s(67,111,112,105,101,100,33),Content=_s(68,105,115,99,111,114,100,32,108,105,110,107,32,99,111,112,105,101,100,32,116,111,32,99,108,105,112,98,111,97,114,100,46),Duration=3,Image=_s(99,108,105,112,98,111,97,114,100,45,99,111,112,121)})
end})
end
