diff --git a/suckless/dwm/dwm.c b/suckless/dwm/dwm.c
--- a/suckless/dwm/dwm.c
+++ b/suckless/dwm/dwm.c
@@ -748,7 +748,7 @@ drawbar(Monitor *m)
     char ctmp;
 	Client *c;
     int correct = 0; /* correction for colours */
  

     for ( ; *ts != '\0' ; ts++)
       if (*ts < LENGTH(colors))
         correct += TEXTW("A") - lrpad;
@@ -794,12 +794,12 @@ drawbar(Monitor *m)
 	if ((w = m->ww - sw - x) > bh) {
 		if (m->sel) {
 			drw_setscheme(drw, scheme[m == selmon ? SchemeSel : SchemeNorm]);
-			drw_text(drw, x, 0, w, bh, lrpad / 2, m->sel->name, 0);
+			drw_text(drw, x, 0, w + correct, bh, lrpad / 2, m->sel->name, 0);
 			if (m->sel->isfloating)
 				drw_rect(drw, x + boxs, boxs, boxw, boxw, m->sel->isfixed, 0);
 		} else {
 			drw_setscheme(drw, scheme[SchemeNorm]);
-			drw_rect(drw, x, 0, w, bh, 1, 1);
+			drw_rect(drw, x, 0, w + correct, bh, 1, 1);
 		}
 	}
 	drw_map(drw, m->barwin, 0, 0, m->ww, bh);
