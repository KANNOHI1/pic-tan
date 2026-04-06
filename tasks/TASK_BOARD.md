# Task Board

Last updated: 2026-03-06 (MKT-005~007 added)
Status: `READY`, `IN_PROGRESS`, `REVIEW`, `DONE`, `BLOCKED`

| ID | Status | Owner | Updated | Task | Acceptance Criteria |
|---|---|---|---|---|---|
| PT-001 | DONE | Codex | 2026-03-04 | Define Swift data models for vocabulary card and study session | Models compile; sample content decodes successfully |
| PT-002 | DONE | Claude | 2026-03-04 | Implement content loader from `packages/content` into iOS app layer | App can read 15 animal entries from local JSON |
| PT-003 | DONE | Claude | 2026-03-04 | Build MVP card screen with 4 study modes | User can switch modes and flip/advance cards |
| PT-004 | DONE | Claude | 2026-03-04 | Add self-assessment actions (`perfect/ok/hard/unknown`) | Action is persisted to in-memory session state |
| PT-005 | DONE | Claude | 2026-03-04 | Create basic mascot reaction mapping for answer outcomes | At least 2 reaction states render in UI |
| PT-006 | DONE | Codex | 2026-03-04 | Add core tests for review-queue seed algorithm | Tests cover all 4 ratings and next-review calculation |
| PT-007 | DONE | Codex | 2026-03-04 | Add content validation script for vocabulary JSON | Script fails on missing required fields |
| PT-008 | DONE | Claude | 2026-03-04 | Create Xcode project and wire PicTanCore dependency | App builds and launches in iOS simulator |
| PT-009 | DONE | Claude | 2026-03-04 | Add content JSON files to iOS bundle resources | `ContentLoader` can load locale files at runtime |
| PT-010 | DONE | Codex | 2026-03-04 | Establish supervisor/implementer restart-safe operating docs | Roles and restart checklist documented in docs |
| PT-011 | BLOCKED | Claude | 2026-03-04 | First macOS Xcode simulator build verification and fix pass | App builds/runs on simulator, core flow works, issues logged |
| PT-012 | READY | Codex | 2026-03-04 | App Store submission prep checklist and metadata draft | Non-engineer checklist prepared, missing decisions explicit |
| PT-013 | DONE | Claude | 2026-03-04 | Create Mac build playbook (for users without Mac) | Step-by-step doc exists for rental/shared Mac setup, first build, and fallback paths |
| PT-014 | DONE | Codex | 2026-03-04 | Memory-zero restart hardening | Single entrypoint docs and bootstrap script available for Codex/Claude |
| PT-015 | READY | Claude | 2026-03-04 | Release QA checklist for iOS MVP build | Manual test list + pass/fail log template ready for simulator/device verification |
| PT-016 | DONE | Codex | 2026-03-05 | App Store metadata package finalized (JP/US) | Submission-ready metadata pack exists in `docs/release/appstore_listing_v1_freeze.md` with count checks |
| PT-017 | READY | Codex | 2026-03-04 | Legal and operational submission prerequisites | Privacy policy hosting plan, support email spec, and account prerequisite checklist documented |
| PT-018 | READY | Codex | 2026-03-04 | Release critical path orchestration | Ordered go-live checklist with blockers, owners, and completion gates documented |
| PT-019 | DONE | Codex | 2026-03-04 | Add browser preview app for collaborative verification | `apps/web` serves locally and reproduces MVP study loop with shared content |
| PT-020 | DONE | Claude | 2026-03-04 | VocabularyCard縺ｫemoji繝輔ぅ繝ｼ繝ｫ繝芽ｿｽ蜉・ｽE・ｽE・ｽE・ｽ繝｢繝・・ｽE・ｽ・ｽE・ｽ+JSON・ｽE・ｽE・ｽE・ｽE| VocabularyCard.swift + animals.json・ｽE・ｽE・ｽE・ｽEa-JP/en-US・ｽE・ｽE・ｽE・ｽ縺ｫemoji霑ｽ蜉縲∝虚迚ｩ20譫壹↓諡｡蜈・|
| PT-021 | DONE | Claude | 2026-03-04 | CardView繧貞ｭ蝉ｾ帛髄縺代↓蛻ｷ譁ｰ・ｽE・ｽE・ｽE・ｽ邨ｵ譁・・ｽE・ｽ・ｽE・ｽ螟ｧ陦ｨ遉ｺ繝ｻ螟ｧ繝懊ち繝ｳ・ｽE・ｽE・ｽE・ｽE| 邨ｵ繝｢繝ｼ繝峨〒 emoji竕･130pt 陦ｨ遉ｺ縲ヾtudyMode.isImageMode 霑ｽ蜉縲・・ｽ・ｽE繧ｿ繝ｳ縺ｫ邨ｵ譁・・ｽE・ｽ・ｽE・ｽ繝ｩ繝吶Ν |
| PT-022 | DONE | Claude | 2026-03-04 | 繝幢ｿｽE繝逕ｻ髱｢・ｽE・ｽE・ｽE・ｽ繝・・ｽE繝樣∈謚橸ｼ峨ｒ霑ｽ蜉 | HomeView.swift 譁ｰ隕丈ｽ懶ｿｽE縲・繝・・ｽE・ｽE繝樣∈謚橸ｿｽECardStudyView驕ｷ遘ｻ縲∵綾繧具ｿｽE繧ｿ繝ｳ |
| PT-023 | DONE | Claude | 2026-03-04 | 繝輔Ν繝ｼ繝・・ｽE・ｽE濶ｲ繧ｳ繝ｳ繝・・ｽE・ｽ・ｽE・ｽ繝ЙSON霑ｽ蜉 | fruits.json・ｽE・ｽE・ｽE・ｽE2譫夲ｼ・ colors.json・ｽE・ｽE・ｽE・ｽE0譫夲ｼ泳a-JP/en-US蜷・繝輔ぃ繧､繝ｫ縲（OS Resources蜷梧悄 |
| PT-024 | DONE | Claude | 2026-03-04 | 繝槭せ繧ｳ繝・・ｽE・ｽ・ｽE・ｽ繧堤ｵｵ譁・・ｽE・ｽ・ｽE・ｽ繧ｭ繝｣繝ｩ繧ｯ繧ｿ繝ｼ縺ｫ謾ｹ蝟・| 瀬繝呻ｿｽE繧ｹ4迥ｶ諷具ｼ・dle/thinking/happy/struggling・ｽE・ｽE・ｽE・ｽE繝舌え繝ｳ繧ｹ繧｢繝九Γ+蜷ｹ縺搾ｿｽE縺励Λ繝吶Ν |
| PT-025 | DONE | Claude | 2026-03-04 | 繧ｻ繝・・ｽE・ｽ・ｽE・ｽ繝ｧ繝ｳ螳御ｺ・・ｽE・ｽ・ｽE・ｽ髱｢繧貞ｼｷ蛹厄ｼ医せ繧ｳ繧｢繝ｻ譏溘い繝九Γ・ｽE・ｽE・ｽE・ｽE| SessionCompleteView.swift・ｽE・ｽE・ｽE・ｽ豁｣隗｣謨ｰ/邱乗椢謨ｰ繝ｻ譏・谿ｵ髫趣ｿｽE[繧ゅ≧荳蠎ｦ][繝・・ｽE・ｽE繝樣∈謚枉 |
| PT-026 | DONE | Claude | 2026-03-04 | 繝悶Λ繧ｦ繧ｶ繝励Ξ繝薙Η繝ｼ繧堤ｵｵ譁・・ｽE・ｽ・ｽE・ｽ蟇ｾ蠢懊↓譖ｴ譁ｰ | apps/web・ｽE・ｽE・ｽE・ｽ・ｽE・ｽE繝ｼ繝逕ｻ髱｢繝ｻ邨ｵ繝｢繝ｼ繝臥ｵｵ譁・・ｽE・ｽ・ｽE・ｽ螟ｧ陦ｨ遉ｺ繝ｻ螳御ｺ・・ｽE・ｽ・ｽE・ｽ髱｢繝ｻ蟄蝉ｾ帛髄縺繕I蜈ｨ髱｢蛻ｷ譁ｰ |
| PT-027 | DONE | Claude | 2026-03-04 | 繝励Ο繧ｸ繧ｧ繧ｯ繝育畑Skill菴懶ｿｽE・ｽE・ｽE・ｽE・ｽEclaude/skills/pic-tan-ios・ｽE・ｽE・ｽE・ｽE| SKILL.md菴懶ｿｽE縲√そ繝・・ｽE・ｽ・ｽE・ｽ繝ｧ繝ｳ襍ｷ蜍墓凾縺ｫ閾ｪ蜍戊ｪ崎ｭ倡｢ｺ隱肴ｸ医∩ |
| PT-028 | DONE | Codex | 2026-03-04 | 繧ｳ繝ｳ繝・・ｽE・ｽ・ｽE・ｽ繝・・ｽE・ｽ・ｽE・ｽ繝ｪ繝・・ｽE・ｽE繧ｷ繝ｧ繝ｳ繧ｹ繧ｯ繝ｪ繝励ヨ繧弾moji蠢・・ｽE・ｽ・ｽE・ｽ繝輔ぅ繝ｼ繝ｫ繝峨↓蟇ｾ蠢・| validate_content.py 縺・emoji 繝輔ぅ繝ｼ繝ｫ繝画ｬ謳阪ｒ讀懃衍縺励※fail縺吶ｋ |
| PT-029 | DONE | Claude | 2026-03-04 | Core繝・・ｽE・ｽE繧ｿ繝｢繝・・ｽE・ｽ・ｽE・ｽ繝・・ｽE・ｽ・ｽE・ｽ繝医ｒemoji繝輔ぅ繝ｼ繝ｫ繝峨↓蟇ｾ蠢・+ fetch繝代せ菫ｮ豁｣ | VocabularyCardDecodingTests 3繝・・ｽE・ｽ・ｽE・ｽ繝磯夐℃繝ｻfetch邨ｶ蟇ｾ繝代せ蛹厄ｿｽE3JSON HTTP 200遒ｺ隱肴ｸ医∩・ｽE・ｽE・ｽE・ｽEodex繝ｬ繝薙Η繝ｼ蠕・・ｽE・ｽ・ｽE・ｽ・ｽE・ｽE・ｽE・ｽE|
| PT-030 | BLOCKED | Claude | 2026-03-04 | 騾ｲ謐玲ｰｸ邯壼喧・ｽE・ｽE・ｽE・ｽEserDefaults・ｽE・ｽE・ｽE・ｽE| 繧ｻ繝・・ｽE・ｽ・ｽE・ｽ繝ｧ繝ｳ邨ゆｺ・・ｽE・ｽ・ｽE・ｽ縺ｫ繧｢繝励Μ蜀崎ｵｷ蜍輔＠縺ｦ繧ょ推繝・・ｽE・ｽE繝橸ｿｽE蟄ｦ鄙貞ｱ･豁ｴ縺梧ｮ九ｋ・ｽE・ｽE・ｽE・ｽEac蜈･謇句ｾ鯉ｼ・|
| PT-031 | DONE | Antigravity | 2026-03-04 | 繝橸ｿｽE繧ｱ繝・・ｽE・ｽ・ｽE・ｽ繝ｳ繧ｰ謌ｦ逡･ & Go-to-Market繝励Λ繝ｳ遲門ｮ・| 繧ｳ繝ｳ繧ｻ繝励ヨ3譯域ｯ碑ｼ・・ｽE・ｽE謗ｨ螂ｨ譯育｢ｺ螳壹・・ｽ・ｽE繝阪ち繧､繧ｺ險ｭ險医、pp Store繝｡繝・・ｽE・ｽ・ｽE・ｽ繝ｼ繧ｸ繝ｳ繧ｰ縲・0譌･GTM繝励Λ繝ｳ縲∽ｻｮ隱ｬ讀懆ｨｼ險ｭ險医ゅΘ繝ｼ繧ｶ繝ｼ謇ｿ隱肴ｸ医∩ |


| PT-032 | DONE | Claude | 2026-03-05 | Concept-driven UX reboot (Home/Study/Complete) | Web preview reflects a 3-minute daily mission flow and felt-cute visual consistency |
| PT-033 | DONE | Claude | 2026-03-05 | Playstyle redesign for engagement | Session loop is mission-like with clear goals, rewards, and replay motivation |
| PT-034 | DONE | Claude | 2026-03-05 | Parent trust layer in product UI | Parent-facing trust/progress panel exists (ad-free/privacy notes + simple progress summary) |
| PT-035 | READY | Codex | 2026-03-05 | Experience acceptance rubric for redesign | Testable rubric for fun/clarity/retention/trust is documented before review |
| PT-036 | DONE | Antigravity | 2026-03-05 | 隕ｪ蜷代￠繧ｨ繝薙ョ繝ｳ繧ｹ險ｭ險・Evidence Brief |
| PT-037 | DONE | Claude | 2026-03-05 | 3谿ｵ髫弱き繝ｼ繝芽｡ｨ遉ｺ・育ｵｵ竊脱N竊貞・陦ｨ遉ｺ・・| 蜈ｨ繝｢繝ｼ繝峨〒 stage 0/1/2 蜍穂ｽ懊∬ｩ穂ｾ｡繝懊ち繝ｳ縺ｯ stage 2 縺ｮ縺ｿ陦ｨ遉ｺ縲∵怙邨・stage 縺ｯ邨ｵ+EN+JA蜈ｨ陦ｨ遉ｺ |
| PT-038 | DONE | Claude | 2026-03-05 | 繧ｻ繝・す繝ｧ繝ｳ蜀・せ繝壹・繧ｷ繝ｳ繧ｰ繝ｪ繝斐す繝ｧ繝ｳ | unknown竊・譫壼ｾ後↓蜀阪く繝･繝ｼ(譛螟ｧ2蝗・縲”ard竊・譫壼ｾ後↓蜀阪く繝･繝ｼ(譛螟ｧ1蝗・縲｛k/perfect竊貞・繧ｭ繝･繝ｼ縺ｪ縺・|
| PT-039 | DONE | Claude | 2026-03-05 | 縺ｾ縺｡縺ｮ謌宣聞繝薙ず繝･繧｢繝ｩ繧､繧ｼ繝ｼ繧ｷ繝ｧ繝ｳ | localStorage 縺ｧ繧ｻ繝・す繝ｧ繝ｳ螳御ｺ・焚繧呈ｰｸ邯壼喧縲・繝ｬ繝吶Ν(験竊停惠)繧偵・繝ｼ繝+螳御ｺ・判髱｢縺ｫ陦ｨ遉ｺ |
| PT-040 | DONE | Claude | 2026-03-05 | 菫晁ｭｷ閠・ヱ繝阪Ν蟄ｦ鄙偵う繝ｳ繝・Φ繝亥ｼｷ蛹・| 邨ｵ縺ｧ諠ｳ襍ｷ/譌･闍ｱ縺ｮ邨舌・縺､縺・蜿榊ｾｩ縺ｧ螳夂捩 縺ｮ3轤ｹ繧偵お繝薙ョ繝ｳ繧ｹ繝吶・繧ｹ縺ｧ隱ｬ譏弱∬ｪ・ｼｵ縺ｪ縺・|EE| 遘大ｭｦ逧・諡E逕ｻ蜒丞━菴肴ｧ蜉ｹ譫懃ｭ会ｼ峨↓蝓ｺ縺･縺・縺､縺ｮ荳ｻ蠑ｵ縲，laim Table縲√せ繝医い譁・縲・0譌･讀懆ｨｼ險育判繧堤ｭ門ｮ・|
| PT-041 | DONE | Antigravity | 2026-03-05 | 繝槭・繧ｱ蜷代￠繝｡繝・そ繝ｼ繧ｸ蜀榊ｮ夂ｾｩ | App Store譁・ｨA/B縲゛P/US縺ｮ蝗ｽ蛻･繝ｭ繝ｼ繧ｫ繝ｩ繧､繧ｺ謖・・縲√♀繧医・譛邨ゅヶ繝ｩ繝ｳ繝峨Γ繝・そ繝ｼ繧ｸ3轤ｹ繧堤ｭ門ｮ・|
| PT-042 | DONE | Antigravity | 2026-03-05 | App Store metadata final (JP/US) | PT-016逶ｴ邨舌・螳溽畑繝｡繧ｿ繝・・繧ｿ・医ち繧､繝医Ν/繧ｵ繝悶ち繧､繝医Ν/隱ｬ譏取枚/繧ｭ繝ｼ繝ｯ繝ｼ繝会ｼ峨ｒ譌･邀ｳ荳｡險隱槭〒讒狗ｯ・|
| PT-043 | DONE | Antigravity | 2026-03-05 | 繧ｹ繧ｯ繝ｪ繝ｼ繝ｳ繧ｷ繝ｧ繝・ヨ逕ｨ繧ｳ繝斐・闕画｡・| 繧ｹ繧ｯ繧ｷ繝ｧ1縲・譫夂岼縺ｮ繧ｳ繝斐・・医ち繧､繝医Ν+1陦瑚｣懆ｶｳ・峨ｒ縲、・亥ｮ牙ｿ・ｨｴ豎ゑｼ峨→B・亥柑譫懆ｨｴ豎ゑｼ峨・2繝代ち繝ｼ繝ｳ菴懈・ |
| PT-044 | DONE | Antigravity | 2026-03-05 | 蟇ｩ譟ｻ蜑阪メ繧ｧ繝・け繧ｷ繝ｼ繝茨ｼ・llowed / Forbidden・・| App Store逕ｳ隲句燕縺ｫ菴ｿ縺・∫ｦ∵ｭ｢陦ｨ迴ｾ・域勹陦ｨ豕輔・隱・､ｧ蠎・相・峨メ繧ｧ繝・け繝ｪ繧ｹ繝医ｒ1繝壹・繧ｸ縺ｫ髮・ｴ・|
| PT-045 | DONE | Claude | 2026-03-05 | 蟷ｴ鮨｢繧ｫ繝・ざ繝ｪ・・asy/Core/Challenge・牙ｮ溯｣・| 繝帙・繝逕ｻ髱｢縺ｫ繧ｿ繝冶｡ｨ遉ｺ縲√き繝ｼ繝峨ｒageBand縺ｧ繝輔ぅ繝ｫ繧ｿ縲√そ繝・す繝ｧ繝ｳ譫壽焚Easy=8/Core=20/Challenge=14縺ｫ蛻ｶ髯・|
| PT-046 | DONE | Claude | 2026-03-05 | 繧ｳ繝ｳ繝・Φ繝・せ繧ｭ繝ｼ繝・v2・・geBand/promptType蠢・亥喧・・| validate_content.py譖ｴ譁ｰ縲∵里蟄・繝輔ぃ繧､繝ｫ蜈ｨ譖ｴ譁ｰ縲∝ｾ梧婿莠呈鋤邯ｭ謖・ｼ・ord_en||answerEn遲会ｼ・|
| PT-047 | DONE | Claude | 2026-03-05 | 譁ｰ隕上ユ繝ｼ繝・v1 窶・蝗ｽ譌礼ｳｻ3繝・・繝・| g7_flags(Core,7鬥夜・)/g20_flags(Challenge,12鬥夜・)/eurozone_flags(Challenge,8鬥夜・) JSON菴懈・(ja-JP/en-US) |
| PT-048 | DONE | Claude | 2026-03-05 | 繝励Ξ繧､菴馴ｨ鍋ｵｱ蜷茨ｼ・T-037+038+蟷ｴ鮨｢蟶ｯ・・| Easy=8譫・谿ｵ髫手｡ｨ遉ｺ/蜀阪く繝･繝ｼ蜈ｨ蟶ｯ縺ｧ蜍穂ｽ懃｢ｺ隱阪’lag cards promptHint="鬥夜・縺ｯ・・繧・谿ｵ髫手｡ｨ遉ｺ縺ｫ謗･邯・|
| PT-049 | DONE | Claude | 2026-03-05 | 菫晁ｭｷ閠・ヱ繝阪Ν陦ｨ遉ｺ縺ｮ蟷ｴ鮨｢蟶ｯ蟇ｾ蠢・| PT-040縺ｮ蟄ｦ鄙偵う繝ｳ繝・Φ繝・轤ｹ繧貞ｹｴ鮨｢蟶ｯ縺ｫ髢｢繧上ｉ縺夊｡ｨ遉ｺ邯ｭ謖・ｼ・llowed wording貅匁侠・・|
| PT-050 | DONE | Claude | 2026-03-05 | 蜿励￠蜈･繧後ユ繧ｹ繝茨ｼ・T-046 蟇ｾ蠢懶ｼ・| validate_content.py 12繝輔ぃ繧､繝ｫ蜈ｨ騾夐℃遒ｺ隱肴ｸ医∩縲仝eb繝励Ξ繝薙Η繝ｼ end-to-end 蜍穂ｽ懃｢ｺ隱埼・岼繧・HANDOFF_LOG 縺ｫ險倬鹸 |
| PT-051 | DONE | Claude | 2026-03-05 | 蝗ｽ譌励き繝ｼ繝峨ョ繝ｼ繧ｿ諡｡蠑ｵ・・ountry_* + capital_*・・| 蜈ｨ6繝輔Λ繧ｰJSON(ja-JP/en-US)縺ｫ country_en/ja繝ｻcapital_en/ja 霑ｽ蜉縲『ord_en=country_en 縺ｧ蠕梧婿莠呈鋤 |
| PT-052 | DONE | Claude | 2026-03-05 | 蟷ｴ鮨｢蟶ｯ縺斐→縺ｮ繧ｯ繧､繧ｺ繝ｭ繧ｸ繝・け蛻・ｲ・| Easy=繝輔Λ繧ｰ繝・・繝樣撼陦ｨ遉ｺ+繧ｬ繝ｼ繝峨，ore=蝗ｽ譌冷・蝗ｽ蜷阪，hallenge=蝗ｽ譌冷・鬥夜・(Stage2縺ｧ蝗ｽ蜷堺ｽｵ險・ |
| PT-053 | DONE | Claude | 2026-03-05 | UI譁・ｨ縺ｨ繝偵Φ繝郁ｪｿ謨ｴ | getPromptHint()縺ｧCore="縺ｩ縺薙・縺上↓・・/Challenge="鬥夜・縺ｯ・・縲∝ｮ御ｺ・判髱｢菫晁ｭｷ閠・ヱ繝阪Ν縺ｫ蟄ｦ鄙偵ち繧､繝苓｡ｨ遉ｺ |
| PT-054 | DONE | Claude | 2026-03-05 | 讀懆ｨｼ繧ｹ繧ｯ繝ｪ繝励ヨ譖ｴ譁ｰ・医ヵ繝ｩ繧ｰ蠢・医ヵ繧｣繝ｼ繝ｫ繝会ｼ・| validate_content.py: _flags繝・・繝槭↓country_*/capital_*蠢・医Ν繝ｼ繝ｫ霑ｽ蜉縲・2繝輔ぃ繧､繝ｫ蜈ｨ騾夐℃ |
| PT-055 | DONE | Claude | 2026-03-05 | 蝗槫ｸｰ繝・せ繝医→繝上Φ繝峨が繝・| TASK_BOARD/HANDOFF_LOG譖ｴ譁ｰ縲∵､懆ｨｼ騾夐℃遒ｺ隱阪∝屓蟶ｰ遒ｺ隱埼・岼繧定ｨ倬鹸 |
| PT-056 | DONE | Antigravity | 2026-03-05 | App Store謠仙・繝代ャ繧ｱ繝ｼ繧ｸ蛹・| docs/release/appstore_listing_v1_freeze.md 繧呈眠隕丈ｽ懈・縺励゛P/US縺ｮ繝｡繧ｿ繝・・繧ｿ縺ｨ譁・ｭ玲焚繧呈紛逅・＠縺・|
| PT-057 | DONE | Antigravity | 2026-03-05 | 繧ｹ繧ｯ繧ｷ繝ｧ驕狗畑莉墓ｧ俶嶌 | docs/release/screenshot_spec.md 繧呈眠隕丈ｽ懈・縺励√せ繧ｯ繧ｷ繝ｧ1-5譫夂岼縺ｮ蠖ｹ蜑ｲ縺ｨA/B蟇ｾ雎｡繧呈・險倥＠縺・|
| PT-058 | DONE | Antigravity | 2026-03-05 | App Store謠仙・蜑阪・繝ｬ繝輔Λ繧､繝・| docs/release/appstore_preflight.md 繧呈眠隕丈ｽ懈・縺励∝ｯｩ譟ｻ蜑阪メ繧ｧ繝・け繝ｪ繧ｹ繝医ｒ邨ｱ蜷医∵凾邉ｻ蛻励〒遒ｺ隱榊庄閭ｽ縺ｫ縺励◆ |
| PT-059 | DONE | Antigravity | 2026-03-05 | App Store繝代ャ繧ｱ繝ｼ繧ｸ繧ｿ繧ｹ繧ｯ險倬鹸譖ｴ譁ｰ | TASK_BOARD.md, HANDOFF_LOG.md, STATE_SNAPSHOT.md 縺ｫ菴懈･ｭ迥ｶ諷九→謌先棡迚ｩ繧貞渚譏縺励◆ |
| PT-060 | DONE | Antigravity | 2026-03-05 | App Store Listing v1 Freeze | docs/release/appstore_listing_v1_freeze.md を作成し、JP/USの最終文言を固定。これ以降の変更はA/Bテスト結果に基づくものに限定した |
| PT-061 | DONE | Antigravity | 2026-03-05 | A/B計測・判定基準の具体化 | docs/release/ab_test_measurement.md を作成し、A/Bテストの判定期間、必要サンプル、採用閾値と勝ちパターン不在ルールの数値を明確に定義した |
| PT-062 | DONE | Antigravity | 2026-03-05 | 審査QA・想定問答集作成 | docs/release/appstore_qa_templates.md を作成し、Apple審査および親向けの想定質問10項目（安全性・学習効果等）と回答を整備した |
| PT-063 | DONE | Claude | 2026-03-05 | Mac受け渡しパック（PT-011実行用） | docs/release/mac_build_handoff.md 作成。Xcode手順・ビルドターゲット・ログ採取・合否10項目チェックリストをコピペ形式で集約 |
| PT-064 | DONE | Claude | 2026-03-05 | タスク状態の整合（PT-060〜062番号衝突修正） | Antigravity PT-060〜062との番号衝突を検出・修正。Claudeタスクをpt-063〜065に再採番。TASK_BOARD/STATE_SNAPSHOT更新 |
| PT-065 | DONE | Claude | 2026-03-05 | Web回帰チェック（提出前） | docs/release/web_regression_report.md 作成。Easy/Core/Challenge 全動線を静的コードレビューで確認。minBand表示フィルター軽微TODOを記録 |
| PT-066 | DONE | Claude | 2026-03-05 | minBand表示フィルター実装（Web） | themeHiddenAtBand()追加。buildThemeCards/startTheme/buildMissionDots/nextTheme の4箇所を更新。flagHiddenAtBand廃止 |
| PT-067 | DONE | Claude | 2026-03-05 | 回帰レポート更新（PT-066反映） | web_regression_report.md を全面更新。Core g20/eurozone非表示をPASSに変更。残存TODOなし |
| PT-068 | DONE | Antigravity | 2026-03-05 | 国旗テーマの親向け説明文 | docs/marketing/flag_difficulty_guide.md 作成。なぜCoreは国名・Challengeは首都なのか、年齢別の発達段階に合わせた理由を親向けに説明する文案を作成。誇大表現を排除。 |
| PT-069 | DONE | Antigravity | 2026-03-05 | ストア素材の地域差分最終化 | docs/release/screenshot_copy_final.md 作成。スクショ1枚目・2枚目の初期リリース版として、JPはパターンA（安心訴求）、USはパターンB（学習効果訴求）を暫定採用するルールを確定した。 |
| PT-070 | DONE | Antigravity | 2026-03-05 | 価格訴求の整合チェック | docs/marketing/pricing_communication_guide.md 作成。「買い切り¥480」の適切な表記場所、画像内や子供用画面への表記NGルール、為替による断定表現NGのガイドラインをまとめた。 |
| PT-071 | DONE | Claude | 2026-03-05 | 既存画像の同期確認（iOS/Web） | animals 20/20・fruits 12/12・colors 10/10・g7_flags 7/7 = 49枚 iOS/Web完全一致確認済み。g20 0/12・eurozone 1/8 = 19枚不足を明示 |
| PT-072 | DONE | Claude | 2026-03-05 | Web フォールバック表示実装 | cardImageHTML() 追加。Stage0/1 で PNG を優先表示、onerror で emoji にフォールバック。CSS .card-img/.card-img-sm 追加 |
| PT-073 | DONE | Claude | 2026-03-05 | カバレッジ自動確認運用化 | check_image_coverage.py（既存）を実行し docs/IMAGE_COVERAGE_REPORT.md 生成。同期済み 50枚 / 不足 19枚（g20×12, eurozone×7）を確認 |
| PT-074 | DONE | Claude | 2026-03-05 | 受け入れ確認（PT-071~073） | animals/fruits/colors/g7_flags 100%反映済み。欠損はレポートに明示。Web画像欠損時クラッシュなし（onerror fallback）確認。TASK_BOARD/HANDOFF_LOG更新 |
| PT-075 | DONE | Antigravity | 2026-03-05 | 街メイン化のメッセージ設計 | docs/marketing/town_growth_messaging.md にホーム/完了/親パネルの「街が育つ達成感」を主語としたコピーを作成 |
| PT-076 | DONE | Antigravity | 2026-03-05 | 親子共遊コピーの設計 | 同ドキュメント内に、責めない・継続を称賛するトーンの「一緒に見る・ほめる・続ける」コミュニケーション用短文コピー10本を作成 |
| PT-077 | DONE | Antigravity | 2026-03-05 | 街成長報酬カタログ | 12段階の街成長・報酬ネーミング（木〜お城）と、各段階で親に見せる価値の定義を作成 |
| PT-078 | DONE | Antigravity | 2026-03-05 | 地域差分の整合確認 | 街育成メッセージがJP/US両方で破綻なく使えるか、また誇張表現や価格断定がないことをレビュー・確認済み |
| PT-079 | DONE | Claude | 2026-03-05 | まち成長12段階化（PT-076相当） | TOWN_LEVELS を7→12段階に拡張。各段階に grew 文言定義。次ゴール CTA "あと〇回でパン屋" を home/complete に表示 |
| PT-080 | DONE | Claude | 2026-03-05 | 親子共遊モード・成長レポート（PT-077相当） | "おうちの人に見せる" ボタン追加。buildParentSummary() を街の成長レポートトーンに全面改訂。責めないコピー |
| PT-081 | DONE | Claude | 2026-03-05 | 継続streak実装（PT-078相当） | localStorage pictan_streak/pictan_streak_date で日次streak。home に streak-badge 表示。complete に streak-inline 表示 |
| PT-082 | DONE | Claude | 2026-03-05 | UIコピー世界観統一（PT-079相当） | hero-tagline "街を育てよう！"。完了タイトル "今日も街が育った！"。ボタン "もう一度育てる/別のミッションへ"。親サマリー "街の成長レポート" |
| PT-083 | DONE | Antigravity | 2026-03-05 | Town-Centric App Store素材更新案 | docs/marketing/town_centric_store_materials.md 作成。街メイン版の概要文およびスクショA/Bコピーを定義 |
| PT-084 | DONE | Antigravity | 2026-03-05 | 親向けLP構成案 | docs/marketing/landing_page_structure.md 作成。1ページの親向けLP構成（課題共感→3分習慣→街成長→安全性→価格）を定義 |
| PT-085 | DONE | Antigravity | 2026-03-05 | 3か月シーズナル運用カレンダー | docs/marketing/seasonal_campaign_calendar.md 作成。春・GW・梅雨のイベントに対する街の見た目変化と実装負荷を記述 |
| PT-086 | DONE | Claude | 2026-03-05 | テーマバッジSVG仮実装（PT-083相当） | apps/web/assets/theme-icons/ に theme_g7.svg・theme_g20.svg・theme_eurozone.svg を新規作成。テキストなし・背景透過・子ども向け丸形バッジ |
| PT-087 | DONE | Claude | 2026-03-05 | WebテーマUIをバッジ画像優先へ変更（PT-084相当） | THEMES に themeIcon パス追加。buildThemeCards() を img優先+emoji fallback に更新。CSS .theme-badge-img/.theme-icon-wrap 追加 |
| PT-088 | DONE | Claude | 2026-03-05 | 差し替え容易化・命名規約文書化（PT-085相当） | THEME_ICON_BASE 定数を app.js に1箇所集約。IMAGE_GENERATION_GUIDE_FLAGS_MAPS.md にバッジ命名規約・差し替え手順を追記 |
| PT-089 | DONE | Claude | 2026-03-05 | 回帰確認（PT-086相当） | minBand フィルター変更なし・クリック導線変更なし・onerror fallback 実装済み確認 |
| PT-090 | DONE | Claude | 2026-03-05 | 記録更新（PT-087相当） | TASK_BOARD/HANDOFF_LOG/STATE_SNAPSHOT 更新 |
| PT-091 | DONE | Antigravity | 2026-03-06 | US文言リスク修正 | docs/marketing/town_centric_store_materials.md の USスクショ2枚目の "smarter kid"（誇大表現リスク）を "lasting skills" へ修正し、禁止用語チェックリストをクリア。 |
| PT-092 | DONE | Antigravity | 2026-03-06 | 街メイン版の最終ストアパック化 | docs/release/appstore_listing_v1_freeze.md に街メインの概要文（JP/US）を統合。スクショA/Bテスト時の採用暫定パターン（JP=A, US=B）を明記し v1.1 としてFreeze。 |
| PT-093 | DONE | Antigravity | 2026-03-06 | シーズナル運用の実装ブリーフ化 | docs/marketing/seasonal_campaign_calendar.md を表形式の実装ブリーフに更新。各月の対象アセットID・コピー文言・エンジニアリング負荷（Low/Medium/High）を明示し、開発・運営での可読性を向上。 |
| PT-094 | DONE | Antigravity | 2026-03-06 | 街体験専用のKPI設計 | docs/marketing/town_growth_kpi.md 新規作成。Town到達率（Lv4=60%、Lv7=30%）および親子共遊導線クリック率（15%）と継続率の目標を定義。14日間のコホート観察ルールを策定。 |
| MKT-001 | DONE | Antigravity | 2026-03-06 | Town-Centric Metadata v1.2草案 | docs/marketing/town_centric_metadata_v1_2_draft.md として街成長訴求の簡素化・審査安全版（JP/US）を作成。 |
| MKT-002 | DONE | Antigravity | 2026-03-06 | スクショ実制作ブリーフ最終化 | docs/marketing/screenshot_production_brief.md を作成し、1-5枚目のコピー・要素（1,2枚目はA/Bパターン含む）を制作会社に渡せる粒度で固定。 |
| MKT-003 | DONE | Antigravity | 2026-03-06 | KPI計測イベント定義書 | docs/marketing/kpi_event_spec.md に town_level_reached, parent_report_opened, session_completed 等の実装仕様を定義。 |
| MKT-004 | DONE | Antigravity | 2026-03-06 | 季節運用の最小実装版 | docs/marketing/seasonal_operations_minimal_plan.md を作成し、開発負荷Lowのアセット上書き施策のみの3ヶ月版とした。 |
| DEV-001 | DONE | Claude | 2026-03-06 | カード体験を「画像主役」に修正 | Stage0=260px/Stage1=220px/Stage2=200px に拡大。Stage2 emoji → cardImageHTML() に置き換え (EN+JA 維持)。.card min-height 280px。flags Challenge の country note 維持。onerror fallback 存続 |
| DEV-002 | DONE | Claude | 2026-03-07 | app.js 文字化け完全除去 + 安定化 | node --check PASS。全20箇所超のSJIS混入文字列を正規UTF-8に復元。card-media-slot統一・showScreen確認・flag Challenge note維持。文字化けパターン検出0件 |
| DEV-003 | DONE | Claude | 2026-03-11 | enablePremiumFx フラグ実装（P2） | app.js L28 に `const enablePremiumFx = false`。Complete 画面のみ 3演出（shimmer/star-pop/glow）を OFF 時ゼロ差分で実装。styles.css に pfx-* CSS追加。node --check PASS |
| DEV-004 | DONE | Codex | 2026-04-07 | Web UI/UX polish pass for `apps/web` | 指定の画面遷移/カード演出/完了演出/ハート順次点灯を実装し、既存スコア・localStorage・SRS を変更しない |
| MKT-005 | DONE | Antigravity | 2026-03-06 | Town-Centricコピー最終固定 v1.3 | docs/release/appstore_listing_v1_freeze.md をv1.3に更新し、JP/US別に3観点（審査安全・親訴求・実装しやすさ）のチェックを追加した最終採用文言に統合。 |
| MKT-006 | DONE | Antigravity | 2026-03-06 | 低負荷イベント運用テンプレ | docs/marketing/seasonal_operations_template.md を実行テンプレとして作成。「差し替えファイル名」「反映先」「所要時間」「ロールバック手順」を明記。 |
| MKT-007 | DONE | Antigravity | 2026-03-06 | KPIレビュー運用台本 | docs/marketing/kpi_review_script.md を作成。1ページで指標と判定基準、未達時アクションを定義した隔週レビュー会議用スクリプト。 |
| IMG-001 | IN_PROGRESS | Gemini (IMG) | 2026-03-06 | Town Asset Generation Batch A | Batch A (town_level_01~12 + 4 rewards) generated and placed in iOS/Web folders. |
