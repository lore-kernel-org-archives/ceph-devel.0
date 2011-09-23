From: Sage Weil <sage@newdream.net>
Subject: Re: [PATCH] crushtool: fix args parsing
Date: Thu, 22 Sep 2011 21:40:33 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1109222139590.8663@cobra.newdream.net>
References: <1316709560-6521-1-git-send-email-henry.cy.chang@gmail.com>
 <Pine.LNX.4.64.1109220943590.17520@cobra.newdream.net>
 <CANExM-OrCz8S5R6XAkwERoNDcqBVPc6VU_OhyJ1hqjq8_eFhdg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-1122080699-1316752833=:8663"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:51729 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750833Ab1IWEkd (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 23 Sep 2011 00:40:33 -0400
In-Reply-To: <CANExM-OrCz8S5R6XAkwERoNDcqBVPc6VU_OhyJ1hqjq8_eFhdg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Henry C Chang <henry.cy.chang@gmail.com>
Cc: ceph-devel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-1122080699-1316752833=:8663
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Fri, 23 Sep 2011, Henry C Chang wrote:
> Hi Sage,
>=20
> In fact, I got two problems with the crushtool after upgrading from
> 0.34 to 0.35.
>=20
> 1. crushtool failed to parse args.
>=20
> I have a template crushmap (as attached) which only consists of the
> root. For each disk, I will use the crushtool to add it to the
> crushmap. The command series look like:
>=20
> $ crushtool -i /etc/ceph/crush.template --add-item 0 1.0 device0 --loc
> host host0 --loc cluster cluster0 -o /tmp/crush0
> $ crushtool -i /tmp/crush0 --add-item 1 1.0 device1 --loc host host0
> --loc cluster cluster0 -o /tmp/crush1
>=20
>=20
> 2. crushtool rejected the command due to the commit 58f98e7.
>=20
> I inverted the commit when upgrading to v0.35.

Yep, those were both broken.  Fixed it in the stable branch, and added a=20
simple unit test to make sure it stays that way.  Please let me know it if=
=20
gives you any further problems.

Thanks!
sage


>=20
> Henry
>=20
> 2011/9/23 Sage Weil <sage@newdream.net>:
> > Hey Henry-
> >
> > Do you have a list of commands that were failing handy? =A0I'd like to
> > extend the cli unit tests at the same time (src/test/cli/crushtool).
> >
> > Thanks-
> > sage
> >
> >
> > On Fri, 23 Sep 2011, Henry C Chang wrote:
> >
> >> Fix --add-item and --loc args parsing.
> >>
> >> Signed-off-by: Henry C Chang <henry.cy.chang@gmail.com>
> >> ---
> >> =A0src/crushtool.cc | =A0 13 +------------
> >> =A01 files changed, 1 insertions(+), 12 deletions(-)
> >>
> >> diff --git a/src/crushtool.cc b/src/crushtool.cc
> >> index 51531aa..f0ccb9b 100644
> >> --- a/src/crushtool.cc
> >> +++ b/src/crushtool.cc
> >> @@ -872,9 +872,6 @@ int main(int argc, const char **argv)
> >> =A0 =A0 =A0 =A0}
> >> =A0 =A0 =A0 =A0if (i =3D=3D args.end())
> >> =A0 =A0 =A0 usage();
> >> - =A0 =A0 =A0i =3D args.erase(i);
> >> - =A0 =A0 =A0if (i =3D=3D args.end())
> >> - =A0 =A0 usage();
> >> =A0 =A0 =A0 =A0add_weight =3D atof(*i);
> >> =A0 =A0 =A0 =A0i =3D args.erase(i);
> >> =A0 =A0 =A0 =A0if (i =3D=3D args.end())
> >> @@ -885,9 +882,6 @@ int main(int argc, const char **argv)
> >> =A0 =A0 =A0 =A0std::string type(val);
> >> =A0 =A0 =A0 =A0if (i =3D=3D args.end())
> >> =A0 =A0 =A0 usage();
> >> - =A0 =A0 =A0i =3D args.erase(i);
> >> - =A0 =A0 =A0if (i =3D=3D args.end())
> >> - =A0 =A0 usage();
> >> =A0 =A0 =A0 =A0std::string name(*i);
> >> =A0 =A0 =A0 =A0i =3D args.erase(i);
> >> =A0 =A0 =A0 =A0add_loc[type] =3D name;
> >> @@ -897,9 +891,6 @@ int main(int argc, const char **argv)
> >> =A0 =A0 =A0 =A0reweight_name =3D val;
> >> =A0 =A0 =A0 =A0if (i =3D=3D args.end())
> >> =A0 =A0 =A0 usage();
> >> - =A0 =A0 =A0i =3D args.erase(i);
> >> - =A0 =A0 =A0if (i =3D=3D args.end())
> >> - =A0 =A0 usage();
> >> =A0 =A0 =A0 =A0reweight_weight =3D atof(*i);
> >> =A0 =A0 =A0 =A0i =3D args.erase(i);
> >> =A0 =A0 =A0} else if (ceph_argparse_flag(args, i, "--build", (char*)NU=
LL)) {
> >> @@ -954,10 +945,8 @@ int main(int argc, const char **argv)
> >> =A0 =A0 =A0 =A0int dev =3D tmp;
> >> =A0 =A0 =A0 =A0if (i =3D=3D args.end())
> >> =A0 =A0 =A0 usage();
> >> - =A0 =A0 =A0i =3D args.erase(i);
> >> - =A0 =A0 =A0if (i =3D=3D args.end())
> >> - =A0 =A0 usage();
> >> =A0 =A0 =A0 =A0float f =3D atof(*i);
> >> + =A0 =A0 =A0i =3D args.erase(i);
> >> =A0 =A0 =A0 =A0int w =3D (int)(f * 0x10000);
> >> =A0 =A0 =A0 =A0if (w < 0)
> >> =A0 =A0 =A0 w =3D 0;
> >> --
> >> 1.7.4.1
> >>
> >> --
> >> To unsubscribe from this list: send the line "unsubscribe ceph-devel" =
in
> >> the body of a message to majordomo@vger.kernel.org
> >> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
> >>
> >>
> >
>=20
--557981400-1122080699-1316752833=:8663--
