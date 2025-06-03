# 🛸 Drone-for-Agriculture Roadmap

**Owner:** [Barak Koren]  
**Start Date:** 2025-06-01  
**Target Completion:** 2025-08-31  
**Status:** In Progress

---

## 📌 Project Overview
Build a Pixhawk 6C-based drone that uses PX4 for flight control, ROS 2 Jazzy for middleware, and Godot 4.4.1 for real‑time visualisation.  
The prototype will:  
1. Hover at two programmable heights around palm trees.  
2. Stream camera imagery and sensor data into Godot.  
3. Detect damaged / clogged sprinklers.  
4. Maintain an orchard map showing every surveyed tree.

---

## 📅 Milestones and Timeline

### June 2025 – Foundation & Core Integration

| Week | Dates        | Goals |
|------|--------------|-------|
| **1** | Jun 1 – 7   | [ ] Assemble and configure drone hardware.<br>[ ] Flash PX4 to Pixhawk 6C & verify telemetry.<br>[ ] Achieve first manual hover & land. |
| **2** | Jun 8 – 14  | [ ] Install ROS 2 Jazzy on Ubuntu 24.04.<br>[ ] Bridge PX4 ↔ ROS 2 (micro‑DDS).<br>[ ] Confirm bidirectional message flow. |
| **3** | Jun 15 – 21 | [ ] Install Godot 4.4.1.<br>[ ] Add `godot_ros` / custom GDNative plugin.<br>[ ] Send ROS 2 topics into Godot scene. |
| **4** | Jun 22 – 30 | [ ] Build first 3‑D drone model in Godot.<br>[ ] Animate pose from live ROS 2 data.<br>[ ] Validate visual vs. real pose. |

### July 2025 – Advanced Features & Sensors

| Week | Dates        | Goals |
|------|--------------|-------|
| **5** | Jul 1 – 7   | [ ] Program two‑height hover routine.<br>[ ] Time‑based hover scheduler node. |
| **6** | Jul 8 – 14  | [ ] Mount stereo / RGB cameras.<br>[ ] Publish image streams via ROS 2.<br>[ ] Display video textures in Godot. |
| **7** | Jul 15 – 21 | [ ] Generate orchard map (GeoJSON / custom).<br>[ ] Fuse GPS + VO for positioning.<br>[ ] Visualise drone path & tree IDs. |
| **8** | Jul 22 – 31 | [ ] Implement CV to spot sprinkler leaks/clogs.<br>[ ] Test detection accuracy in field.<br>[ ] Overlay issue markers in Godot. |

### August 2025 – Prototype Refinement & Docs

| Week | Dates        | Goals |
|------|--------------|-------|
| **9** | Aug 1 – 7   | [ ] Full end‑to‑end flight tests.<br>[ ] Stress‑test hover logic and CV pipeline. |
| **10**| Aug 8 – 14  | [ ] Write setup & ops documentation.<br>[ ] Create deployment checklist. |
| **11**| Aug 15 – 21 | [ ] Scope pollination & weed‑spray add‑ons.<br>[ ] List extra hardware / firmware needs. |
| **12**| Aug 22 – 31 | [ ] Optimise code & power draw.<br>[ ] Freeze v1.0 prototype & plan next phase. |

---

## 🚧 Post‑August Backlog
- [ ] Automated pollination module  
- [ ] Weed‑spray boom & flow control  
- [ ] AI crop‑health analytics (leaf colour, stress)  
- [ ] Integration with farm‑management software  

---

## 🔧 Tech Stack

| Layer                | Choice                     |
|----------------------|----------------------------|
| **Flight Controller**| Pixhawk 6C + PX4           |
| **OS / Middleware**  | Ubuntu 24.04 + ROS 2 Jazzy |
| **Visualisation**    | Godot 4.4.1 (GDScript + C++)|
| **Languages**        | C++, Python, GDScript      |
| **Sensors**          | GPS, cameras, optional LiDAR|

---

## 📂 Recommended Repo Layout
```
drone-agriculture/
├─ docs/               # ↳ roadmap.md (this file)
├─ firmware/           # PX4 config & parameters
├─ hardware/           # CAD, wiring schematics
├─ ros2_ws/            # Jazzy workspace
├─ godot/              # Godot 4.4.1 project
└─ README.md
```

---

## 📝 Maintenance Tips
- Tick `[ ] → [x]` as tasks finish; commit roadmap edits.  
- Use GitHub Issues for granular tasks; link them here if useful.  
- Re‑estimate timeline after each weekly review.
