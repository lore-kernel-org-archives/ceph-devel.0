From: Roland Rabben <roland@jotta.no>
Subject: Re: ceph in v2.6.33?
Date: Fri, 1 Jan 2010 22:41:18 +0100
Message-ID: <b418ca0b1001011341g5699bcd3g4355f7251577d357@mail.gmail.com>
References: <Pine.LNX.4.64.0912071511470.32397@cobra.newdream.net>
	<alpine.LFD.2.00.0912181327200.3712@localhost.localdomain>
	<Pine.LNX.4.64.0912181629100.29068@cobra.newdream.net>
	<200912281205.36802.anton.vazir@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5392832251011560327=="
Return-path: <ceph-devel-bounces@lists.sourceforge.net>
In-Reply-To: <200912281205.36802.anton.vazir@gmail.com>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ceph-devel>,
	<mailto:ceph-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ceph-devel>
List-Post: <mailto:ceph-devel@lists.sourceforge.net>
List-Help: <mailto:ceph-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ceph-devel>,
	<mailto:ceph-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: ceph-devel-bounces@lists.sourceforge.net
To: Anton <anton.vazir@gmail.com>
Cc: ceph-devel@lists.sourceforge.net
List-Id: ceph-devel.vger.kernel.org

--===============5392832251011560327==
Content-Type: multipart/alternative; boundary=0003255579226164f1047c213b65

--0003255579226164f1047c213b65
Content-Type: text/plain; charset=UTF-8

I definitly agree with your points Anton. Like you I am silently monitoring
this list for signs of production stability. I really like the potential of
CEPH and would like to help out getting it into the mainline.

Regards
Roland Rabben

2009/12/28 Anton <anton.vazir@gmail.com>

> FS with CEPH abilities is the LOOOOONG time awaited stuff, which I
> (personally) looking so much forward to stabilize - that it could be hardly
> expressed. I't not widelly known yet, but I think a lot of us, who needs
> clustered storage and did own survey of the cluster FS stuff available (like
> gluster, etc) - just siletntly monitor the list for the signs that code is
> stable enough to be used in the production. How should we show our demand fo
> Linus? I would really like to see kernel supporting CEPH in the mainline.
>
>
> On Monday 21 December 2009, Sage Weil wrote:
> > The Ceph kernel client may not make it into .33 after
> > all... in the absense of other issues, Linus would like
> > to see some user demand before merging a new subsystem.
> > If you'd like to see it in mainline sooner, now's the
> > time to speak up.
> >
> > Either way, this doesn't change too much for us. We're
> > still focusing in improving stability and fixing osd
> > performance problems, and not much else. The disk format
> > and wire protocol are very nearly stabilized. An earlier
> > merge would make it easier for people to test the system,
> > but pulling the client from the ceph tree or building the
> > standalone module will make it easier for us to manage
> > bug fixes.
> >
> > sage
> >
> > On Fri, 18 Dec 2009, Linus Torvalds wrote:
> > > On Fri, 18 Dec 2009, Sage Weil wrote:
> > > > I would still like to see ceph merged for 2.6.33.
> > > > It's certainly not production ready, but it would be
> > > > greatly beneficial to be in mainline for the same
> > > > reasons other file systems like btrfs and exofs were
> > > > merged early.
> > >
> > > So what happened to ceph is the same thing that
> > > happened to the alacrityvm pull request (Greg Haskins
> > > added to cc): I pretty much continually had a _lot_ of
> > > pull requests, and all the time the priority for the
> > > ceph and alactrityvm pull requests were just low enough
> > > on my priority list that I never felt I had the reason
> > > to look into the background enough to make an even
> > > half-assed decision of whether to pull or not.
> > >
> > > And no, "just pull" is not my default answer - if I
> > > don't have a reason, the default action is "don't
> > > pull".
> > >
> > > I used to say that "my job is to say 'no'", although
> > > I've been so good at farming out submaintainers that
> > > most of the time my real job is to pull from
> > > submaintainers who hopefully know how to say 'no'. But
> > > when it comes to whole new driver features, I'm still
> > > "no by default - tell me _why_ I should pull".
> > >
> > > So what is a new subsystem person to do?
> > >
> > > The best thing to do is to try to have users that are
> > > vocal about the feature, and talk about how great it
> > > is. Some advocates for it, in other words. Just a few
> > > other people saying "hey, I use this, it's great", is
> > > actually a big deal to me. For alacrityvm and cephfs, I
> > > didn't have that, or they just weren't loud enough for
> > > me to hear.
> > >
> > > So since you mentioned btrfs as an "early merge", I'll
> > > mention it too, as a great example of how something got
> > > merged early because it had easily gotten past my
> > > "people are asking for it" filter, to the point where
> > > _I_ was interested in trying it out personally, and
> > > asking Chris&co to tell me when it was ready.
> > >
> > > Ok, so that was somewhat unusual - I'm not suggesting
> > > you'd need to try to drum up quite _that_ much hype -
> > > but it kind of illustrates the opposite extreme of your
> > > issue. Get some PR going, get people talking about it,
> > > get people testing it out. Get people outside of your
> > > area saying "hey, I use it, and I hate having to merge
> > > it every release".
> > >
> > > Then, when I see a pull request during the merge
> > > window, the pull suddenly has a much higher priority,
> > > and I go "Ok, I know people are using this".
> > >
> > > So no astro-turfing, but real grass-roots support
> > > really does help (or top-down feedback for that matter
> > > - if a _distribution_ says "we're going to merge this
> > > in our distro regardless", that also counts as a big
> > > hint for me that people actually expect to use it and
> > > would like to not go through the pain of merging).
> > >
> > > Linus
> > > --
> > > To unsubscribe from this list: send the line
> > > "unsubscribe linux-fsdevel" in the body of a message to
> > > majordomo@vger.kernel.org More majordomo info at
> > > http://vger.kernel.org/majordomo-info.html
> >
> > ---------------------------------------------------------
> >--------------------- This SF.Net email is sponsored by
> > the Verizon Developer Community Take advantage of
> > Verizon's best-in-class app development support A
> > streamlined, 14 day to market process makes app
> > distribution fast and easy Join now and get one step
> > closer to millions of Verizon customers
> > http://p.sf.net/sfu/verizon-dev2dev
> > _______________________________________________
> > Ceph-devel mailing list
> > Ceph-devel@lists.sourceforge.net
> > https://lists.sourceforge.net/lists/listinfo/ceph-devel
>
>
>
>
>
>
> ------------------------------------------------------------------------------
> This SF.Net email is sponsored by the Verizon Developer Community
> Take advantage of Verizon's best-in-class app development support
> A streamlined, 14 day to market process makes app distribution fast and
> easy
> Join now and get one step closer to millions of Verizon customers
> http://p.sf.net/sfu/verizon-dev2dev
> _______________________________________________
> Ceph-devel mailing list
> Ceph-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ceph-devel
>
>


-- 
Roland Rabben
Founder & CEO Jotta AS
Cell: +47 90 85 85 39
Phone: +47 21 04 29 00
Email: roland@jotta.no

--0003255579226164f1047c213b65
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

I definitly agree with your points Anton. Like you I am silently monitoring=
 this list for signs of production stability. I really like the potential o=
f CEPH and would like to help out getting it into the mainline.<br><br>Rega=
rds<br>
Roland Rabben<br><br><div class=3D"gmail_quote">2009/12/28 Anton <span dir=
=3D"ltr">&lt;<a href=3D"mailto:anton.vazir@gmail.com">anton.vazir@gmail.com=
</a>&gt;</span><br><blockquote class=3D"gmail_quote" style=3D"border-left: =
1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;=
">
<div style=3D"font-family: &#39;Arial&#39;; font-size: 10pt; font-weight: 4=
00; font-style: normal;">FS with CEPH abilities is the LOOOOONG time awaite=
d stuff, which I (personally) looking so much forward to stabilize - that i=
t could be hardly expressed. I&#39;t not widelly known yet, but I think a l=
ot of us, who needs clustered storage and did own survey of the cluster FS =
stuff available (like gluster, etc) - just siletntly monitor the list for t=
he signs that code is stable enough to be used in the production. How shoul=
d we show our demand fo Linus? I would really like to see kernel supporting=
  CEPH in the mainline.<div>
<div></div><div class=3D"h5"><br>
<p style=3D"margin: 0px; text-indent: 0px;"><br></p>On Monday 21 December 2=
009, Sage Weil wrote:<br>
&gt; The Ceph kernel client may not make it into .33 after<br>
&gt; all... in the absense of other issues, Linus would like<br>
&gt; to see some user demand before merging a new subsystem. <br>
&gt; If you&#39;d like to see it in mainline sooner, now&#39;s the<br>
&gt; time to speak up.<br>
&gt;<br>
&gt; Either way, this doesn&#39;t change too much for us.  We&#39;re<br>
&gt; still focusing in improving stability and fixing osd<br>
&gt; performance problems, and not much else.  The disk format<br>
&gt; and wire protocol are very nearly stabilized.  An earlier<br>
&gt; merge would make it easier for people to test the system,<br>
&gt; but pulling the client from the ceph tree or building the<br>
&gt; standalone module will make it easier for us to manage<br>
&gt; bug fixes.<br>
&gt;<br>
&gt; sage<br>
&gt;<br>
&gt; On Fri, 18 Dec 2009, Linus Torvalds wrote:<br>
&gt; &gt; On Fri, 18 Dec 2009, Sage Weil wrote:<br>
&gt; &gt; &gt; I would still like to see ceph merged for 2.6.33. <br>
&gt; &gt; &gt; It&#39;s certainly not production ready, but it would be<br>
&gt; &gt; &gt; greatly beneficial to be in mainline for the same<br>
&gt; &gt; &gt; reasons other file systems like btrfs and exofs were<br>
&gt; &gt; &gt; merged early.<br>
&gt; &gt;<br>
&gt; &gt; So what happened to ceph is the same thing that<br>
&gt; &gt; happened to the alacrityvm pull request (Greg Haskins<br>
&gt; &gt; added to cc): I pretty much continually had a _lot_ of<br>
&gt; &gt; pull requests, and all the time the priority for the<br>
&gt; &gt; ceph and alactrityvm pull requests were just low enough<br>
&gt; &gt; on my priority list that I never felt I had the reason<br>
&gt; &gt; to look into the background enough to make an even<br>
&gt; &gt; half-assed decision of whether to pull or not.<br>
&gt; &gt;<br>
&gt; &gt; And no, &quot;just pull&quot; is not my default answer - if I<br>
&gt; &gt; don&#39;t have a reason, the default action is &quot;don&#39;t<br=
>
&gt; &gt; pull&quot;.<br>
&gt; &gt;<br>
&gt; &gt; I used to say that &quot;my job is to say &#39;no&#39;&quot;, alt=
hough<br>
&gt; &gt; I&#39;ve been so good at farming out submaintainers that<br>
&gt; &gt; most of the time my real job is to pull from<br>
&gt; &gt; submaintainers who hopefully know how to say &#39;no&#39;. But<br=
>
&gt; &gt; when it comes to whole new driver features, I&#39;m still<br>
&gt; &gt; &quot;no by default - tell me _why_ I should pull&quot;.<br>
&gt; &gt;<br>
&gt; &gt; So what is a new subsystem person to do?<br>
&gt; &gt;<br>
&gt; &gt; The best thing to do is to try to have users that are<br>
&gt; &gt; vocal about the feature, and talk about how great it<br>
&gt; &gt; is. Some advocates for it, in other words. Just a few<br>
&gt; &gt; other people saying &quot;hey, I use this, it&#39;s great&quot;, =
is<br>
&gt; &gt; actually a big deal to me. For alacrityvm and cephfs, I<br>
&gt; &gt; didn&#39;t have that, or they just weren&#39;t loud enough for<br=
>
&gt; &gt; me to hear.<br>
&gt; &gt;<br>
&gt; &gt; So since you mentioned btrfs as an &quot;early merge&quot;, I&#39=
;ll<br>
&gt; &gt; mention it too, as a great example of how something got<br>
&gt; &gt; merged early because it had easily gotten past my<br>
&gt; &gt; &quot;people are asking for it&quot; filter, to the point where<b=
r>
&gt; &gt; _I_ was interested in trying it out personally, and<br>
&gt; &gt; asking Chris&amp;co to tell me when it was ready.<br>
&gt; &gt;<br>
&gt; &gt; Ok, so that was somewhat unusual - I&#39;m not suggesting<br>
&gt; &gt; you&#39;d need to try to drum up quite _that_ much hype -<br>
&gt; &gt; but it kind of illustrates the opposite extreme of your<br>
&gt; &gt; issue. Get some PR going, get people talking about it,<br>
&gt; &gt; get people testing it out. Get people outside of your<br>
&gt; &gt; area saying &quot;hey, I use it, and I hate having to merge<br>
&gt; &gt; it every release&quot;.<br>
&gt; &gt;<br>
&gt; &gt; Then, when I see a pull request during the merge<br>
&gt; &gt; window, the pull suddenly has a much higher priority,<br>
&gt; &gt; and I go &quot;Ok, I know people are using this&quot;.<br>
&gt; &gt;<br>
&gt; &gt; So no astro-turfing, but real grass-roots support<br>
&gt; &gt; really does help (or top-down feedback for that matter<br>
&gt; &gt; - if a _distribution_ says &quot;we&#39;re going to merge this<br=
>
&gt; &gt; in our distro regardless&quot;, that also counts as a big<br>
&gt; &gt; hint for me that people actually expect to use it and<br>
&gt; &gt; would like to not go through the pain of merging).<br>
&gt; &gt;<br>
&gt; &gt; 			Linus<br>
&gt; &gt; --<br>
&gt; &gt; To unsubscribe from this list: send the line<br>
&gt; &gt; &quot;unsubscribe linux-fsdevel&quot; in the body of a message to=
<br>
&gt; &gt; <a href=3D"mailto:majordomo@vger.kernel.org" target=3D"_blank">ma=
jordomo@vger.kernel.org</a> More majordomo info at <br>
&gt; &gt; <a href=3D"http://vger.kernel.org/majordomo-info.html" target=3D"=
_blank">http://vger.kernel.org/majordomo-info.html</a><br>
&gt;<br>
&gt; ---------------------------------------------------------<br>
&gt;--------------------- This SF.Net email is sponsored by<br>
&gt; the Verizon Developer Community Take advantage of<br>
&gt; Verizon&#39;s best-in-class app development support A<br>
&gt; streamlined, 14 day to market process makes app<br>
&gt; distribution fast and easy Join now and get one step<br>
&gt; closer to millions of Verizon customers<br>
&gt; <a href=3D"http://p.sf.net/sfu/verizon-dev2dev" target=3D"_blank">http=
://p.sf.net/sfu/verizon-dev2dev</a><br>
&gt; _______________________________________________<br>
&gt; Ceph-devel mailing list<br>
&gt; <a href=3D"mailto:Ceph-devel@lists.sourceforge.net" target=3D"_blank">=
Ceph-devel@lists.sourceforge.net</a><br>
&gt; <a href=3D"https://lists.sourceforge.net/lists/listinfo/ceph-devel" ta=
rget=3D"_blank">https://lists.sourceforge.net/lists/listinfo/ceph-devel</a>=
<br>
<p style=3D"margin: 0px; text-indent: 0px;"><br></p><p style=3D"margin: 0px=
; text-indent: 0px;"><br></p><p style=3D"margin: 0px; text-indent: 0px;"><b=
r></p></div></div></div><br>-----------------------------------------------=
-------------------------------<br>

This SF.Net email is sponsored by the Verizon Developer Community<br>
Take advantage of Verizon&#39;s best-in-class app development support<br>
A streamlined, 14 day to market process makes app distribution fast and eas=
y<br>
Join now and get one step closer to millions of Verizon customers<br>
<a href=3D"http://p.sf.net/sfu/verizon-dev2dev" target=3D"_blank">http://p.=
sf.net/sfu/verizon-dev2dev</a> <br>________________________________________=
_______<br>
Ceph-devel mailing list<br>
<a href=3D"mailto:Ceph-devel@lists.sourceforge.net">Ceph-devel@lists.source=
forge.net</a><br>
<a href=3D"https://lists.sourceforge.net/lists/listinfo/ceph-devel" target=
=3D"_blank">https://lists.sourceforge.net/lists/listinfo/ceph-devel</a><br>
<br></blockquote></div><br><br clear=3D"all"><br>-- <br>Roland Rabben<br>Fo=
under &amp; CEO Jotta AS<br>Cell: +47 90 85 85 39<br>Phone: +47 21 04 29 00=
<br>Email: <a href=3D"mailto:roland@jotta.no">roland@jotta.no</a><br>

--0003255579226164f1047c213b65--


--===============5392832251011560327==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
This SF.Net email is sponsored by the Verizon Developer Community
Take advantage of Verizon's best-in-class app development support
A streamlined, 14 day to market process makes app distribution fast and easy
Join now and get one step closer to millions of Verizon customers
http://p.sf.net/sfu/verizon-dev2dev 
--===============5392832251011560327==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ceph-devel mailing list
Ceph-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ceph-devel

--===============5392832251011560327==--
