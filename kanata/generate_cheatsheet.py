"""
Generate a clean, high-resolution dark-mode cheat sheet graphic and PDF for the
One-Handed Keyboard layout, saving as layout_cheatsheet.png and layout_cheatsheet.pdf.
"""

from PIL import Image, ImageDraw, ImageFont
import os

# Master resolution scale factor (2 = 3200x2040 Ultra-HD / Retina)
SCALE = 2

def S(val):
    """Scales a coordinate or dimension by the master SCALE factor."""
    return int(val * SCALE)

def get_font(size, bold=False):
    scaled_size = S(size)
    font_names = [
        "C:/Windows/Fonts/segoeuib.ttf" if bold else "C:/Windows/Fonts/segoeui.ttf",
        "C:/Windows/Fonts/arialbd.ttf" if bold else "C:/Windows/Fonts/arial.ttf",
        "C:/Windows/Fonts/consola.ttf"
    ]
    for font_path in font_names:
        if os.path.exists(font_path):
            try:
                return ImageFont.truetype(font_path, scaled_size)
            except Exception:
                pass
    return ImageFont.load_default()

def draw_card(draw, x, y, w, h, title, bg_color=(30, 30, 46), border_color=(69, 71, 90), title_color=(137, 180, 250)):
    # Draw card background
    draw.rounded_rectangle([x, y, x + w, y + h], radius=S(12), fill=bg_color, outline=border_color, width=S(2))
    # Draw title
    font_title = get_font(18, bold=True)
    draw.text((x + S(18), y + S(14)), title, fill=title_color, font=font_title)
    # Header separator
    draw.line([x + S(18), y + S(42), x + w - S(18), y + S(42)], fill=border_color, width=S(1))

def draw_keycap(draw, x, y, w, h, phys, out, subtext=None, is_highlight=False):
    bg = (49, 50, 68) if not is_highlight else (49, 65, 85)
    border = (108, 112, 134) if not is_highlight else (137, 220, 235)
    draw.rounded_rectangle([x, y, x + w, y + h], radius=S(8), fill=bg, outline=border, width=S(2))
    
    # Physical key (small top-left)
    font_phys = get_font(12, bold=False)
    draw.text((x + S(8), y + S(6)), phys, fill=(166, 173, 200), font=font_phys)
    
    # Output character (large center)
    font_out = get_font(20, bold=True)
    out_color = (205, 214, 244) if not is_highlight else (249, 226, 175)
    draw.text((x + w - S(24) if len(out) == 1 else x + S(16), y + S(16)), out, fill=out_color, font=font_out)
    
    if subtext:
        font_sub = get_font(10, bold=False)
        draw.text((x + S(8), y + h - S(16)), subtext, fill=(147, 153, 178), font=font_sub)

def main():
    W, H = S(1600), S(1020)
    img = Image.new("RGBA", (W, H), (24, 24, 37, 255))
    draw = ImageDraw.Draw(img)

    # -------------------------------------------------------------
    # 1. HEADER
    # -------------------------------------------------------------
    font_logo = get_font(28, bold=True)
    font_sub = get_font(15, bold=False)
    draw.text((S(40), S(24)), "ONE-HANDED KEYBOARD CHEAT SHEET", fill=(203, 166, 247), font=font_logo)
    draw.text((S(40), S(62)), "Hyn (Halmak) Mode  •  Spacebar Mirror  •  Left-Hand Accessibility Layout", fill=(166, 173, 200), font=font_sub)

    # Badge in header
    draw.rounded_rectangle([W - S(380), S(26), W - S(40), S(72)], radius=S(8), fill=(49, 50, 68), outline=(137, 180, 250), width=S(1))
    font_badge = get_font(14, bold=True)
    draw.text((W - S(365), S(38)), "TOGGLE: [ Tab + Q ] (Hyn Mode Only)", fill=(137, 220, 235), font=font_badge)

    # -------------------------------------------------------------
    # 2. SECTION 1: BASE LAYER (HYN / HALMAK)
    # -------------------------------------------------------------
    card1_x, card1_y, card1_w, card1_h = S(40), S(100), S(480), S(265)
    draw_card(draw, card1_x, card1_y, card1_w, card1_h, "1. BASE LAYER (HYN / HALMAK) - DEFAULT", title_color=(137, 180, 250))
    
    keys_base = [
        [("Q", "c"), ("W", "s"), ("E", "t"), ("R", "h"), ("T", "r")],
        [("A", "a"), ("S", "e"), ("D", "i"), ("F", "o"), ("G", "u")],
        [("Z", "l"), ("X", "d"), ("C", "n"), ("V", "m"), ("B", "NVDA")]
    ]
    kw, kh = S(80), S(60)
    pad_x, pad_y = S(10), S(8)
    start_kx, start_ky = card1_x + S(18), card1_y + S(55)
    for r_idx, row in enumerate(keys_base):
        for c_idx, (phys, out) in enumerate(row):
            kx = start_kx + c_idx * (kw + pad_x)
            ky = start_ky + r_idx * (kh + pad_y)
            is_hl = (phys == "B")
            draw_keycap(draw, kx, ky, kw, kh, phys, out, is_highlight=is_hl)

    # -------------------------------------------------------------
    # 3. SECTION 2: MIRROR LAYER (HOLD SPACEBAR)
    # -------------------------------------------------------------
    card2_x, card2_y, card2_w, card2_h = S(540), S(100), S(480), S(265)
    draw_card(draw, card2_x, card2_y, card2_w, card2_h, "2. MIRROR LAYER (HOLD SPACEBAR)", title_color=(249, 226, 175))
    
    keys_mirror = [
        [("Q", "z"), ("W", "b"), ("E", "p"), ("R", "y"), ("T", "x")],
        [("A", "q"), ("S", "g"), ("D", "w"), ("F", "f"), ("G", "v")],
        [("Z", "c"), ("X", "b"), ("C", "k"), ("V", "j"), ("B", "Win+H")]
    ]
    start_kx2 = card2_x + S(18)
    for r_idx, row in enumerate(keys_mirror):
        for c_idx, (phys, out) in enumerate(row):
            kx = start_kx2 + c_idx * (kw + pad_x)
            ky = start_ky + r_idx * (kh + pad_y)
            is_hl = (phys == "B")
            draw_keycap(draw, kx, ky, kw, kh, phys, out, is_highlight=is_hl)

    # -------------------------------------------------------------
    # 4. SECTION 3: MOUSE & NAV MODE (TAP L-CTRL)
    # -------------------------------------------------------------
    card3_x, card3_y, card3_w, card3_h = S(1040), S(100), S(520), S(265)
    draw_card(draw, card3_x, card3_y, card3_w, card3_h, "3. MOUSE NAVIGATION MODE (TAP L-CTRL)", title_color=(166, 227, 161))
    
    font_bold = get_font(13, bold=True)
    font_val = get_font(13, bold=False)
    
    mouse_items = [
        ("W / A / S / D", "Move Cursor Up / Left / Down / Right (Accelerating)"),
        ("Q / E", "Mouse Wheel Up / Down (Scroll)"),
        ("CapsLock", "Left Click (Hold to Drag)"),
        ("Left Shift", "Right Click"),
        ("Middle Click", "Toggle NVDA (B-Key Mode in Hyn/Nav)"),
        ("Ctrl + B", "Toggle Middle Click B-Mode ON/OFF"),
        ("Space + CapsLock", "Send Enter"),
        ("Q + W / W + E", "Home / End (Quick Jump)")
    ]
    m_y = card3_y + S(46)
    for key, desc in mouse_items:
        draw.text((card3_x + S(18), m_y), key, fill=(249, 226, 175), font=font_bold)
        draw.text((card3_x + S(172), m_y), desc, fill=(205, 214, 244), font=font_val)
        m_y += S(26)

    # -------------------------------------------------------------
    # 5. SECTION 4: NAVIGATION & EDITING CHORDS
    # -------------------------------------------------------------
    card4_x, card4_y, card4_w, card4_h = S(40), S(375), S(480), S(305)
    draw_card(draw, card4_x, card4_y, card4_w, card4_h, "4. NAVIGATION & EDITING CHORDS", title_color=(137, 220, 235))
    
    nav_edit_items = [
        ("W + E", "Up Arrow", "A + F", "Ctrl + C  (Copy)"),
        ("S + D", "Down Arrow", "A + F (Mir)", "Ctrl + V  (Paste)"),
        ("A + S", "Left Arrow", "Z + C", "Ctrl + X  (Cut)"),
        ("D + F", "Right Arrow", "Z + X", "Ctrl + Z  (Undo)"),
        ("Q + W", "Home", "C + V", "Ctrl + Y  (Redo)"),
        ("E + R", "End", "S + F", "Backspace"),
        ("Q + W (Mir)", "Page Up", "S + D + F", "Ctrl + Backspace"),
        ("E + R (Mir)", "Page Down", "A + D", "Delete"),
        ("Z+X+C+V", "Escape (Esc)", "A + D (Mir)", "Insert (Ins)"),
    ]
    ne_y = card4_y + S(50)
    for col1_k, col1_v, col2_k, col2_v in nav_edit_items:
        draw.text((card4_x + S(16), ne_y), col1_k, fill=(249, 226, 175), font=font_bold)
        draw.text((card4_x + S(115), ne_y), col1_v, fill=(205, 214, 244), font=font_val)
        
        draw.text((card4_x + S(240), ne_y), col2_k, fill=(249, 226, 175), font=font_bold)
        draw.text((card4_x + S(355), ne_y), col2_v, fill=(205, 214, 244), font=font_val)
        ne_y += S(27)

    # -------------------------------------------------------------
    # 6. SECTION 5: SYMBOL & PUNCTUATION CHORDS
    # -------------------------------------------------------------
    card5_x, card5_y, card5_w, card5_h = S(540), S(375), S(480), S(305)
    draw_card(draw, card5_x, card5_y, card5_w, card5_h, "5. PUNCTUATION & SYMBOLS", title_color=(245, 194, 231))
    
    symbols_data = [
        ("S + E", "/  (Slash)", "S + E (Mir)", "\\  (Backslash)"),
        ("G + R", "?  (Question)", "G + R (Mir)", "|  (Pipe)"),
        ("A + G", "@  (At sign)", "W + T (Mir)", "]  (Close Bracket)"),
        ("Q + R", "{  (Open Brace)", "Q + R (Mir)", "}  (Close Brace)"),
        ("S + G", "(  (Open Paren)", "S + G (Mir)", ")  (Close Paren)"),
        ("W + T", "[  (Open Bracket)", "F + E (Mir)", ":  (Colon)"),
        ("A + W", "\"  (Double Quote)", "A + W (Mir)", "'  (Single Quote)"),
        ("S+E+F", "=  (Equals)", "S+E+F (Mir)", "+  (Plus)"),
    ]
    sym_y = card5_y + S(55)
    for c1_k, c1_v, c2_k, c2_v in symbols_data:
        draw.text((card5_x + S(20), sym_y), c1_k, fill=(249, 226, 175), font=font_bold)
        draw.text((card5_x + S(100), sym_y), c1_v, fill=(205, 214, 244), font=font_val)
        
        draw.text((card5_x + S(240), sym_y), c2_k, fill=(249, 226, 175), font=font_bold)
        draw.text((card5_x + S(345), sym_y), c2_v, fill=(205, 214, 244), font=font_val)
        sym_y += S(28)

    # -------------------------------------------------------------
    # 7. SECTION 6: MEDIA, BRIGHTNESS & SPECIAL SHORTCUTS
    # -------------------------------------------------------------
    card6_x, card6_y, card6_w, card6_h = S(1040), S(375), S(520), S(305)
    draw_card(draw, card6_x, card6_y, card6_w, card6_h, "6. MEDIA, BRIGHTNESS & UTILITIES", title_color=(250, 179, 135))
    
    media_data = [
        ("A + R", "Volume Up", "G + E", "Seek Forward (5s)"),
        ("Q + F", "Volume Down", "G + W", "Seek Rewind (5s)"),
        ("A + R (Mir)", "Mute Audio", "A + T", "Brightness Up"),
        ("G + T", "Play / Pause", "Q + G", "Brightness Down"),
        ("Q + T", "Screen Capture", "W + E + R", ".  (Period)"),
        ("R + W", ",  (Comma)", "F + E", ";  (Semicolon)"),
        ("Q + E", "<  (Less Than)", "E + T", ">  (Greater Than)"),
        ("F + G", "_  (Underscore)", "F + G (Mir)", "-  (Hyphen / Minus)"),
    ]
    med_y = card6_y + S(50)
    for c1_k, c1_v, c2_k, c2_v in media_data:
        draw.text((card6_x + S(20), med_y), c1_k, fill=(249, 226, 175), font=font_bold)
        draw.text((card6_x + S(125), med_y), c1_v, fill=(205, 214, 244), font=font_val)
        
        draw.text((card6_x + S(265), med_y), c2_k, fill=(249, 226, 175), font=font_bold)
        draw.text((card6_x + S(370), med_y), c2_v, fill=(205, 214, 244), font=font_val)
        med_y += S(30)

    # -------------------------------------------------------------
    # 8. SECTION 7: CORE MODIFIERS & FUNCTION KEYS
    # -------------------------------------------------------------
    card7_x, card7_y, card7_w, card7_h = S(40), S(695), S(1520), S(235)
    draw_card(draw, card7_x, card7_y, card7_w, card7_h, "7. CORE MODIFIERS & FUNCTION KEYS (F1–F12)", title_color=(203, 166, 247))

    mod_boxes = [
        ("SPACEBAR (Thumb)", "• Tap: Types standard Space\n• Hold: Activates Mirror Layer\n• Hold Space + B: Win + H (Dictation)\n• Hold Space + 1..5: 0..6 (Numbers)"),
        ("FUNCTION KEYS (F1–F12)", "• F1..F5 Alone: Normal F1..F5\n• Space + F5..F1: F6..F10 (Rev Mirror)\n• Space + Esc + F1: F11 (Fullscreen)\n• Space + F1 + F2: F12 (DevTools)"),
        ("PHYSICAL 'B' & MID-CLICK", "• In Hyn/Nav: Toggle [ NVDA ] (Admin)\n• Middle Click: Acts as 'B' (NVDA)\n• Ctrl + B: Toggle M-Click Mode\n• Space + B / Mid-Click: Win + H"),
        ("LEFT CONTROL", "• Tap: Toggle Mouse Navigation ON/OFF\n• Hold: Control Layer (Helper shortcuts)\n• Hold Ctrl + Space: Mirror shortcut chords\n• Instant arrow & pointer access"),
        ("PHYSICAL ESC (Win)", "• In Hyn: Left Win (Start/Fn)\n• Z+X+C+V: Pure Escape (Esc)\n• Space + Esc + F1: F11 (Fullscreen)\n• In QWERTY: Standard Escape")
    ]
    box_w = S(286)
    box_gap = S(14)
    b_x = card7_x + S(16)
    b_y = card7_y + S(50)
    for title, desc in mod_boxes:
        draw.rounded_rectangle([b_x, b_y, b_x + box_w, b_y + S(165)], radius=S(8), fill=(38, 38, 56), outline=(69, 71, 90), width=S(1))
        draw.text((b_x + S(10), b_y + S(10)), title, fill=(137, 180, 250), font=get_font(13, bold=True))
        draw.line([b_x + S(10), b_y + S(32), b_x + box_w - S(10), b_y + S(32)], fill=(69, 71, 90), width=S(1))
        
        d_y = b_y + S(40)
        for line in desc.split("\n"):
            draw.text((b_x + S(10), d_y), line, fill=(205, 214, 244), font=get_font(11))
            d_y += S(28)
        b_x += box_w + box_gap

    # -------------------------------------------------------------
    # 9. FOOTER BAR
    # -------------------------------------------------------------
    draw.rounded_rectangle([S(40), S(945), W - S(40), S(995)], radius=S(10), fill=(30, 30, 46), outline=(137, 180, 250), width=S(2))
    font_footer = get_font(15, bold=True)
    footer_text = "CONTROLS: Show: [ Tab + Q ] (Pin/Peek)  |  Mid-Click: NVDA Toggle (Hyn/Nav)  |  Toggle Mode: [ Ctrl + B ]  |  Zoom: Wheel  |  Pan: Mid-Drag"
    draw.text((S(60), S(960)), footer_text, fill=(249, 226, 175), font=font_footer)

    # Save PNG (lossless Super-Resolution)
    output_png = os.path.join(os.path.dirname(__file__), "layout_cheatsheet.png")
    img.save(output_png, "PNG", optimize=True)
    print(f"Generated Super-Resolution PNG ({W}x{H}) successfully at: {output_png}")

    # Save PDF (vector-rasterized document for offline reading/printing)
    output_pdf = os.path.join(os.path.dirname(__file__), "layout_cheatsheet.pdf")
    rgb_img = img.convert("RGB")
    rgb_img.save(output_pdf, "PDF", resolution=150.0)
    print(f"Generated PDF successfully at: {output_pdf}")

if __name__ == "__main__":
    main()
