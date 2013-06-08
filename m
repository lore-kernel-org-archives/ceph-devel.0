From: Loic Dachary <loic@dachary.org>
Subject: PGLog::rewind_divergent_log use case
Date: Sat, 08 Jun 2013 10:16:13 +0200
Message-ID: <51B2E84D.6090001@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig7A1600824AF02EE5442442B8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.dmail.dachary.org ([86.65.39.20]:59374 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751447Ab3FHIQS (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 8 Jun 2013 04:16:18 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Samuel Just <sam.just@inktank.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig7A1600824AF02EE5442442B8
Content-Type: multipart/mixed;
 boundary="------------000805040801010709040404"

This is a multi-part message in MIME format.
--------------000805040801010709040404
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

[Note: ceph-devel cc'ed]

Hi Sam,

While trying to create the conditions for the following to happen in PGLo=
g::rewind_divergent_log:

    if (p =3D=3D log.log.begin()) {
      // yikes, the whole thing is divergent!
      divergent.swap(log.log);
      break;
    }

https://github.com/ceph/ceph/blob/master/src/osd/PGLog.cc#L355

I created this ( matching the drawing attached ), and the test case works=
=2E=20

    {
      pg_log_entry_t e;

      info.log_tail =3D log.tail =3D eversion_t(1, 1);
      newhead =3D eversion_t(1, 3);
      e.version =3D divergent_version =3D eversion_t(1, 5);
      e.soid.hash =3D 0x9;
      divergent_object =3D e.soid;
      e.op =3D pg_log_entry_t::DELETE;
      e.prior_version =3D prior_version =3D eversion_t(0, 2);
      log.log.push_back(e);
      log.head =3D e.version;
    }

https://github.com/dachary/ceph/commit/d592d7f10968c56139cb470a4111ddfbe0=
8a4030#L0R136

But it does not look like a situation that is actually going to happen. I=
 feel something is missing and a hint would be much appreciated :-)

Cheers

--=20
Lo=EFc Dachary, Artisan Logiciel Libre
All that is necessary for the triumph of evil is that good people do noth=
ing.

--------------000805040801010709040404
Content-Type: image/png;
 name="a.png"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="a.png"

iVBORw0KGgoAAAANSUhEUgAAAa4AAADuCAIAAADuuHQVAAAXe0lEQVR42u2de0yV5R/A5X5x
iEIoIlqAF0IUzHUBvINRM52pqZnmZVOn5bKNNtyc2pzNksw/NB2tcRO1oKwVCgvvWqg05gXT
ZComlNAgQASB8Pf98ax377gcD+cc4ACfzx9nz/O8l3Oe5znfz3me857zPn0eAwD0evrQBAAA
qBAAABUCAKBCAABUCACACgEAUCEAACoEAECFAACoEAAAFQIAoEIAAFQIAIAKAQBQIQAAKgQA
QIUAAKgQAAAVAgCgQgAAVAgAgAoBAFAhAAAqBABAhQAAqBAAABUCAKBCAABUCACACgEAUCEA
ACoEAECFAACoEAAAFT6BwMDAPtBbkd5HAYAKm+rfh3ExvQ+ACgkGeh8AFRIM9D4AKiQY6H0A
VEgw0PsAqJBgoPdpBECFBAMqpPcBFXZkMKifrfH2QoWAClEhYYYKARWiQsIMFQIqRIX6M2dl
ZU2YMMHV1dXFxSUiIkKy+p33798fEBDg4OAQFBSUlJSERlEhoMIeqEIRn62tbVhY2J07dwoL
CyUhWc2Gx48flz3VVuHFF19EhagQUGEPVKEMAyV97tw5lT179qxkZZCoslOnTpWsFKrs6dOn
USEqBFTYA1Uok2JJV1VVqWxlZaVkpVBlPTw8Wm4lRFEhoEJUiApRIaDCnj5BlkTLCXJOTg4T
ZFQIqLAnq1BdNhEhFhYW3r17VxItL5tMnjxZNnHZBBUCKuyxKnz8349pXJoIDw/PzMzU76x+
TCObQkJC4uPj5UA7OzvemqgQUGHvDYYrV67ISxo1ahRvTVQIqLB3BcOcOXNyc3Nra2uvX78+
ZcoUeUlJSUm8NVEhoMLeFQzp6enjx493cHDo16+fqPDw4cO8L1EhoEKCAeh9QIUEA9D7gAoJ
BqD3ARUSDEDvAyokGIDeB1RIMAC9D6iwC3B2du4DvRXpfRQAqJBxQW9vDXofUCHBQGvQ+4AK
CQZag94HVEgw0Br0PqBCgoHWoPcBFRIMtAa9D6iQYKA16H1AhQRDR7WG4aUILLVQgQUXPKD3
ARUSDKiQ3gdUSDB0ugot+CJRIaBCVNjFraGWrHJ1dXVxcYmIiNCW7tMklZSUFBQU5OjoGBAQ
kJKS0pbCzpw5ExUV5ebm1q9fv/Dw8IyMDP2zXLlyZcGCBd7e3g4ODnK2AwcO6E+iQe8DKkSF
XdAaaiHTsLCwO3fuFBYWSkK/kKnSk9qqljmV7PHjx1uq8MSJE/b29pMmTSooKCgrK1uyZIl+
RZcLFy6IZ4cOHZqdnV1dXX3t2rVFixYxKgRUiAqtpTWaLW9/9uxZ/fL2SlLaVklIdurUqS0V
JhKU9OXLl1X2/v37kh05cqTKRkZGSva7775jggyoEBVaY2vIYE32qaqqUtnKykrJSqFeUs22
enp6tlSYzK9b3idGW/1ZbZXRIioEVIgKe4gKPTw82lJhSUlJq8+itpaXl6NCQIWosBtMkNUU
2IQJslruOS0trdVnmTZtmmz9/vvvW91qY2ODCgEVosKubA112USEWFhYqC6MtLxsot8q2ezs
7JYqPHv2rKOjo5+fX05OzqNHj2T/xMRE2V9tlUJnZ+enn3762LFjDx8+vHHjxtKlS7XX4OPj
I+e5du0avQ+oEBV2WWuoH9O4NBEeHp6Zmdls6ipSCwkJka1iOu2icMuJ7cWLF2fPnu3p6Wlv
by92W7Ro0alTp7Stly5deuONNwYOHChb9T+mERISEgYNGsSPaQAVosLu1xoy9NN/q0jvAypE
hb2uNRoaGg4dOqT/VpHeB1SICntda8hpHRwcXnjhhStXrtD7gApR4ZNfTNe+HhOevYNec6f9
nRkFACpEhagQFQIqJBhQIb0PqNDIYBg3bpzsk56erpWkpaVJiZSrrIE7rKh4rq2tfe+997y8
vGxtbaXw3r17S5cu9fX1dXR0HDRo0Jtvvnn69OlW4/+J94CRVxUWFubs7Ozh4TFz5sxbt251
lQoNvJKDBw+qfZycnEaOHLlx48ZHjx6pTU9sCotXEBUCKjQxGHbv3i37vPbaa1rJjBkzpGTP
nj2Pn3SHFRXPcXFxeXl5DQ0NqnDy5MlSePjwYVFkcXFxamrqxIkTW6rQmHvAhISEyJkrKyu3
bt0qWTlzV6nQwCuJjY09evTogwcPKioqduzYIVs3bNhgZFNYvIKoEFChicFQXl4uoxLx3V9/
/SXZP//8U9IyTFP/kDV8hxUVz7m5ufoT9u3bVwpl+NPY2GhgVmjMPWBycnJUtqqqSg27ukqF
2itR/ztu65XU19fLVn9/fyObwsjTokJAhZ0RDG+99Zbs9umnn0pahniSXrx4sdpk+A4rKltX
V6c/m+hMlcuxoaGhMncuKipqqUJjbnygzTRFJV317wvDr6SkpGTZsmUyBZbPD6191BcFxjSF
xSuICgEVmh4MMguW3caOHSvpMWPGSFpK9Cps6w4rrUbv3bt3ly9fPnToUE0NzcZ6xqvwic/V
aSpsqyQ6OlrNiEtLSyUrE2H9ViObwoIVRIWACk0PBhmSDB8+XPaMj4+XR0lrEzrDd1gxHL0V
FRXqkoLME584QW71HjDWr0I3Nze90E+ePNnq6zTcFKgQUKFVqFD46KOP1KBMHiWtlRu+w0qr
0RsZGXn48GEZSMrE+ciRI7JDVFRUy/2NuQeM9atQ3Y96586d1dXV58+fHzFiRLOtxjQFKgRU
aC0qLCoqsrOzU98DFhcX6zcZuMNKq9Erk+t58+Z5eXmJQ2VuuGLFCnVB5nEbP6YxcA8Y61eh
tNX8+fM9PDycnJxCQ0NTU1ObrXBiZFOgQkCFVqFCWoP6AiokGGgN6guokGCgNagvoEKCgdag
voAKCQZag/oCKiQYaA3qC6iQYKA1qC+gQoKB1qC+gAoJBlqD+gIqJBhoDeoLqJBgoDWoL6BC
goHWoL6ACgkGWoP6AiokGGgN6guokGCgNagvoEKCgdagvoAKezIxMTE1NTUEA2qg98EqVNje
mxLr9zfnhsZyYGhoaF5enqWC4eOPP5aTTJs2TSvJz8/fsmVLUFCQka/T8P5yZimUZ0EN1BdQ
oSVVKDg7O8fFxZkfDPX19UOGDJGT/PLLL1qhSG3z5s1Xr1418nUa3v/nn3+WQnkWeS5rU4N6
watXr25XTxnZlR1xB39UCN1ehZY9VqHWqzOnFpmZmWqYaXHd65HzS7m2xpO1qdDGxkZbmQ8V
Aio00Uf6t6NaAVJwcnIaOXLkxo0btUXBLTsq1HPo0CGTK7J27VoDs1dLqVDNweW5rFOF7u7u
wcHBdf+tfI8KARWaO7KLjY09evTogwcPKioqduzYoVYT72gVCgsXLiwvLzfhbOPHj282O+4I
Fao5sjyXdapw79698rht2zZUCKjQ8pPc+vp62cHf378TVCj4+vqeOHGivWfr37+/HFtaWtqh
KiwpKZHyAQMGWKcKGxsbIyIiXFxcCgoKUCGgQnNVKAG/bNkyUZK9vb1mKFtb285RoUgtMTGx
vWdTiyNrc8MOUqGcX8qlWaxThY+bLoI7OjqqBd1RIaBCs1QYHR2tZsRqkFVbW9tWzFhchVOm
TLl9+7YJZ2NUqB2yadMmSaekpOgL5ZNM0vpr32qw3+onHCqE3qhCGxubZm9ENzc3KamqqlLZ
kydPdo4K4+LiTP6dirq2267vCk0Ifiv/rlCl5aMrMDDQy8tLX/jMM89I+saNG9ohv/32m5T4
+fmhQkCF/8fHx0feiNeuXdNKIiMjpWTnzp3V1dXnz58fMWJER6swODjYzGBYuXJle68gmxD8
6grymjVrrFmFwunTp9UnnFa4a9cuSct4//r16zU1NfIok2gpkXJUCKjw/yQkJAwaNEj/di8u
Lp4/f76Hh4eTk5OMtlJTUztUhevXr5fgNDMYMjIyWv1dYcuxpyovKiqStHwMGLm/fuyZmZlp
5SoUVq1a1awwOTl5woQJ7u7uMimWR0lLieHvK564CRVCz1Fhl1W46WJxdna2RYKhrq5u8ODB
chKZwxqzv/qFUExMjPFPYc3/NukBbwYUAL1UhfPmzdP/hND8YNi+fXuz/yAbYOzYsbLzpUuX
jD8//0GmvoAKCQZag/oCKiQYaA3qC6iQYKA1qC+gQoKB1qC+gAoJBlqD+gIqJBhoDeoLqJBg
oDWoL6BCgoHWoL6ACgkGWoP6AiokGGgN6guokGCgNagvoEKCgdagvoAKCQZag/oCKiQYaA3q
C6iQYGhsbKQ1Orm+VVVVy5YtQweoEBWajrrbvv5+hfn5+Vu2bAkKCmrvjZcbGhqmT5/+wQcf
6A/kfoUdXd8zZ86oNVjQASpEhSZSX18/ZMiQZis9iQQ3b9589erV9qpQJBgVFSVC1B9ozXex
Vq9z9erVLQtbpo3f4YmbLFjf2NhYbbFZa3g3dkKVkT4qtLwKMzMzW13bxIS33VdffeXn5/f3
33+3PFCtbZKVlWWdKrSxsTl37ly3U6Fae6/jFk5BhaiwF6lw7dq17V3xrlUuX77s5eWVl5fX
6oFqDi7PZZ0qdHd3Dw4Orqur60Yq3L17t7OzMyoEVGgZFY4fP7696yC3pKysLCAgIDU1ta0D
rXwd5L1798rjtm3buoUK//jjj1deecWc5fTUzgkJCSNGjFCrM2qD4sbGxvj4+DFjxvTt23fU
qFEiXHURTPpXDvn1118lfeDAAUnLo6Rzc3MlPXz4cJPPrPjss8/kQFtbW29v75UrV1ZWVmqb
5Khnn31WzhYUFJSUlIQKUWGHqLB///5yhtLSUnOCWSLz/fffN3BgSUmJZAcMGGCdKpSYjIiI
cHFxKSgosHIVpqenP/XUU33aoF21fvvtt8vLy9USteIatenzzz+X7JIlS/7555+NGzdKet++
fVL+7rvvSlqEJem5c+dKWh41ha1bt87kMys+/PDD/Pz8mpqaL7/8Uja98847qvyLL76Q7IwZ
M4qbkAQqRIUdokI7Ozs5gzY3NC2Yp06d2tDQYOBAOb9k7e3trVOFj5sumjs6OkZFRVm5CuPi
4lrOi01T4b1797SukeGY2iTmkuzNmzclLTqTtIzFJP3jjz9K+vXXX3/48KEM67y8vFxdXaur
q+fMmSPlGRkZJp+5Geqa27Bhw1R29OjRkr1+/brKSgIVokLrHRX2MYj1jwpVetOmTZJOSUnR
F0okS1p/7VvS+gjv/AlyXl6eugxlpgpbzco8tNk5HRwcpFysJ5vEgN9++60UHjlyRB7T0tIG
DhwoahY/mnxmIScnRz6EZLSrWlvfvCJcydbW1qqsDBtRISrsEBWqoGrXd4XGvBe713eFKi3x
FhgYKNGuL1S/17tx44Z2iLpu6+fn11UqVEaIiYnpCBVKvbRhXTOmT58um55//vmXXnpJsmFh
YeqL5pdfftnMM6tG/uGHH2QgWVVVpT+KUSEq7CQVrly5sr1XkE1QobqCvGbNGmtWoXD69Gkb
Gxt94a5duyQdHR0tQSgCkkcZv0iJlHehChUnTpywuApVfRcuXCgThcrKShn9aabbuXOn2nPP
nj3ad3/aF4jmnNnX11c2SeNL+bp16/RHxcfH810hKuwMFWZkZLT6u8K2RhxFRUWS9vHxaVew
qbFnZmamlatQWLVqVbPC5OTkCRMmuLu7y6xNHiUtJYa/HHjiJgvWV+RiQRU+brpALEO/fk28
+uqr2q9B1XBYZrXqp6NlZWWOjo5SIuVmnvnUqVMhISFytmHDhmmG1Y7au3evjNZlpiz7JCYm
okJU2CEqlCnJ4MGD5SQyhzVm/x07dsjOMjsz/ims+d8mPaP39+/fr77zRQeoEBWazvbt25v9
B9kAY8eOlZ0vXbpk/Pn5D3In1Pf27dtTpkxBB6gQFUKvViEAKiQYUCEAKiQYUCEAKiQYUCEA
KiQYUCEAKiQYUCEAKiQYUCGdDqiQYECF9D6gQoIBFdL7gAoJBlqD3gdUSDDQGvQ+oEKCgdag
9wEVEgy0Br0PqJBgoDXofejdKoyJiampqSEYUAO9D52nws68Za7xayqFhobqF18383nV3fb1
9yvMz8/fsmVLUFCQOcs8aVu5XyH1BVTYISoUnJ2d4+LizA+G+vr6IUOGNFvpSSS4efPmq1ev
tusltbW1B9/FOisrS93rX5g1a9a1a9dQIaDCTlWhYsqUKWa+vMzMzFbXNjHhJRnYQa1toq1l
0TPUcPDgQXk6MeCfTUhiwIABd+7cQYXQY1WYnp4eFhYmAzEPD4+ZM2feunVL2+HMmTNRUVFu
bm79+vULDw/X1sbWR4vg5OQ0cuTIjRs3Pnr0SNuanJwcEBDg4OAgo7CkpCSTZ6OHDh0yuYJr
165t74p3Juym5uDyXN1LDcuXL1drlv7777+SlcfnnntOSlasWPH4v3Upf//9d7WzJCS7atUq
VAg9VoUhISF5eXmVlZVbt26V7OTJk9XWEydO2NvbT5o0qaCgoKysbMmSJbJVpKYdHhsbe/To
0QcPHlRUVKgFkjZs2KA2/fTTT5KNiIgobEIS5nwxt3DhwvLychMqqJaybdc6yG3tJp8Hjo6O
fn5+c+fOzcnJaTlHtsJ1kA3z8OFDtZbLvn37HjctvabeDOqylXyG6Vcrl4R+fWRUCD1QhVpg
iw3VEE9lRYKSvXz5ssrev39fsjL6a/VU9fX1stXf319l1dxWW2fu3Llz5qhQ8PX1FTW3t4Jq
pbTS0lJzVDhx4sTU1FSZJIo7Tp48OWrUKBsbm6+//lrboaSkRM4j88dupwYZ68l439PTUxIy
J3B3d79586baNHToUHk6LatGhfJhgAqhx6pQm9U2Njbq7eDq6tpSSXZ2dlr8L1u2TAwlI0dt
q62trdoqcSXZqqoqvWTNUaFILTExsb0VlFcrx9bV1ZmjwmYorQcGBmolcn4pkXbojmoQp8tp
VX998803WrlaIn327Nnqu0JJSLZv376oEHqsCtsqUSoU5bV6bHR0tJoRqzGXmkBpx1pWhTLG
vH37tgkVtMiosBkPHjxoNj7qvqNCIS4uTk7r4+Mjj5988ol+U0pKyrhx4+RtoJaKN3ABChVC
T1ahmuSmpaW1eqybm5tedjJz1B87efJkS02QJVZN/p2Kurbbru8Kn/g6L1y4IDvINFkr6abf
FQq5ubkODg7e3t737t0TG0r64sWLre557NgxefatW7eiQuh1Kjx79qy6UJCTkyOT6MLCQpmi
RkREqK2RkZGyp0yjqqurz58/P2LECP2xWVlZ5l82CQ4ONjMYVq5c2d4ryC0Lw8PDExISpBbS
COKOkJAQGxsb/XVtdQV5zZo13UsN8jE2fPhwOWdycrJkU1NTJS0lMoRXO8yfPz8/P//hw4dn
zpyR/pXukL5GhdDrVCjIGGH27Nmenp729vYyali0aNGpU6fUpuLiYgkVmQg7OTnJ4EsFkv5Y
0Ye/v7+Li4u4QxzaXhWuX7++pqbGzGDIyMhodVrX1r9HioqK1GxRv7MMeBcsWDB48GAZNA0d
OnTWrFkyyG059szMzOxeali8eLGcUGa+WsnEiROlRMpV9sCBA6NHj5Za+/r6rlu3rqysrLPf
/agQOkeF1ljhpovF2dnZFgmGuro6UZh+qm4Y9ZOgmJgY45+iB//bxBreDCgAeqkK582bp/8J
ofnBsH379mb/QTaA+p3dpUuXjD8//0GmvoAKCQZag/oCKiQYaA3qC6iQYKA1qC+gQoKB1qC+
gAoJBlqD+gIqJBhoDeoLqJBgoDWoL6BCgoHWoL6ACgkGWoP6AiokGGgN6guokGCgNagvoEKC
gdagvoAKCQZag/oCKiQYaA3qC6iQYKA1qC+gQoKB1qC+gAoJBlqD+gIqJBhoDeoLqJBgoDWo
L6BCgoHWoL6ACgkGWoP6AirsGry9vfvAf9jZ2fWq+krvowBAhQAAqBAAABUCAKBCAABUCACA
CgEAUCEAACoEAECFAACoEAAAFQIAoEIAAFQIAIAKAQBQIQAAKgQAQIUAAKgQAAAVAgCgQgAA
VAgAgAoBAFAhAAAqBABAhQAAqBAAABUCAKBCAABUCACACgEAUCEAACoEAECFAACoEADAWP4H
azZOk+syj0gAAAAASUVORK5CYII=
--------------000805040801010709040404--

--------------enig7A1600824AF02EE5442442B8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAlGy6E0ACgkQ8dLMyEl6F22TxgCfZFo0hM7XxG12XfvCVr27yVne
ME8AnjfTII9IkqZ03elapCYZrq3lzuGU
=p/NO
-----END PGP SIGNATURE-----

--------------enig7A1600824AF02EE5442442B8--
