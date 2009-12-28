From: Anton <anton.vazir@gmail.com>
Subject: Re: ceph in v2.6.33?
Date: Mon, 28 Dec 2009 12:05:36 +0500
Message-ID: <200912281205.36802.anton.vazir@gmail.com>
References: <Pine.LNX.4.64.0912071511470.32397@cobra.newdream.net>
	<alpine.LFD.2.00.0912181327200.3712@localhost.localdomain>
	<Pine.LNX.4.64.0912181629100.29068@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0553017729599606912=="
Return-path: <ceph-devel-bounces@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.64.0912181629100.29068@cobra.newdream.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ceph-devel>,
	<mailto:ceph-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ceph-devel>
List-Post: <mailto:ceph-devel@lists.sourceforge.net>
List-Help: <mailto:ceph-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ceph-devel>,
	<mailto:ceph-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: ceph-devel-bounces@lists.sourceforge.net
To: ceph-devel@lists.sourceforge.net
List-Id: ceph-devel.vger.kernel.org

--===============0553017729599606912==
Content-Type: multipart/alternative; boundary="Boundary-00=_AjFOLDXLHC88yUr"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

--Boundary-00=_AjFOLDXLHC88yUr
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

FS with CEPH abilities is the LOOOOONG time awaited stuff, 
which I (personally) looking so much forward to stabilize - 
that it could be hardly expressed. I't not widelly known 
yet, but I think a lot of us, who needs clustered storage 
and did own survey of the cluster FS stuff available (like 
gluster, etc) - just siletntly monitor the list for the 
signs that code is stable enough to be used in the 
production. How should we show our demand fo Linus? I would 
really like to see kernel supporting  CEPH in the mainline.

On Monday 21 December 2009, Sage Weil wrote:
> The Ceph kernel client may not make it into .33 after
> all... in the absense of other issues, Linus would like
> to see some user demand before merging a new subsystem. 
> If you'd like to see it in mainline sooner, now's the
> time to speak up.
>
> Either way, this doesn't change too much for us.  We're
> still focusing in improving stability and fixing osd
> performance problems, and not much else.  The disk format
> and wire protocol are very nearly stabilized.  An earlier
> merge would make it easier for people to test the system,
> but pulling the client from the ceph tree or building the
> standalone module will make it easier for us to manage
> bug fixes.
>
> sage
>
> On Fri, 18 Dec 2009, Linus Torvalds wrote:
> > On Fri, 18 Dec 2009, Sage Weil wrote:
> > > I would still like to see ceph merged for 2.6.33. 
> > > It's certainly not production ready, but it would be
> > > greatly beneficial to be in mainline for the same
> > > reasons other file systems like btrfs and exofs were
> > > merged early.
> >
> > So what happened to ceph is the same thing that
> > happened to the alacrityvm pull request (Greg Haskins
> > added to cc): I pretty much continually had a _lot_ of
> > pull requests, and all the time the priority for the
> > ceph and alactrityvm pull requests were just low enough
> > on my priority list that I never felt I had the reason
> > to look into the background enough to make an even
> > half-assed decision of whether to pull or not.
> >
> > And no, "just pull" is not my default answer - if I
> > don't have a reason, the default action is "don't
> > pull".
> >
> > I used to say that "my job is to say 'no'", although
> > I've been so good at farming out submaintainers that
> > most of the time my real job is to pull from
> > submaintainers who hopefully know how to say 'no'. But
> > when it comes to whole new driver features, I'm still
> > "no by default - tell me _why_ I should pull".
> >
> > So what is a new subsystem person to do?
> >
> > The best thing to do is to try to have users that are
> > vocal about the feature, and talk about how great it
> > is. Some advocates for it, in other words. Just a few
> > other people saying "hey, I use this, it's great", is
> > actually a big deal to me. For alacrityvm and cephfs, I
> > didn't have that, or they just weren't loud enough for
> > me to hear.
> >
> > So since you mentioned btrfs as an "early merge", I'll
> > mention it too, as a great example of how something got
> > merged early because it had easily gotten past my
> > "people are asking for it" filter, to the point where
> > _I_ was interested in trying it out personally, and
> > asking Chris&co to tell me when it was ready.
> >
> > Ok, so that was somewhat unusual - I'm not suggesting
> > you'd need to try to drum up quite _that_ much hype -
> > but it kind of illustrates the opposite extreme of your
> > issue. Get some PR going, get people talking about it,
> > get people testing it out. Get people outside of your
> > area saying "hey, I use it, and I hate having to merge
> > it every release".
> >
> > Then, when I see a pull request during the merge
> > window, the pull suddenly has a much higher priority,
> > and I go "Ok, I know people are using this".
> >
> > So no astro-turfing, but real grass-roots support
> > really does help (or top-down feedback for that matter
> > - if a _distribution_ says "we're going to merge this
> > in our distro regardless", that also counts as a big
> > hint for me that people actually expect to use it and
> > would like to not go through the pain of merging).
> >
> > 			Linus
> > --
> > To unsubscribe from this list: send the line
> > "unsubscribe linux-fsdevel" in the body of a message to
> > majordomo@vger.kernel.org More majordomo info at 
> > http://vger.kernel.org/majordomo-info.html
>
> ---------------------------------------------------------
>--------------------- This SF.Net email is sponsored by
> the Verizon Developer Community Take advantage of
> Verizon's best-in-class app development support A
> streamlined, 14 day to market process makes app
> distribution fast and easy Join now and get one step
> closer to millions of Verizon customers
> http://p.sf.net/sfu/verizon-dev2dev
> _______________________________________________
> Ceph-devel mailing list
> Ceph-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ceph-devel




--Boundary-00=_AjFOLDXLHC88yUr
Content-Type: text/html;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0//EN" "http://www.w3.org/TR/REC-html40/strict.dtd"><html><head><meta name="qrichtext" content="1" /><style type="text/css">p, li { white-space: pre-wrap; }</style></head><body style=" font-family:'Arial'; font-size:10pt; font-weight:400; font-style:normal;">FS with CEPH abilities is the LOOOOONG time awaited stuff, which I (personally) looking so much forward to stabilize - that it could be hardly expressed. I't not widelly known yet, but I think a lot of us, who needs clustered storage and did own survey of the cluster FS stuff available (like gluster, etc) - just siletntly monitor the list for the signs that code is stable enough to be used in the production. How should we show our demand fo Linus? I would really like to see kernel supporting  C
 EPH in the mainline.<br>
<p style="-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;"><br></p>On Monday 21 December 2009, Sage Weil wrote:<br>
&gt; The Ceph kernel client may not make it into .33 after<br>
&gt; all... in the absense of other issues, Linus would like<br>
&gt; to see some user demand before merging a new subsystem. <br>
&gt; If you'd like to see it in mainline sooner, now's the<br>
&gt; time to speak up.<br>
&gt;<br>
&gt; Either way, this doesn't change too much for us.  We're<br>
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
&gt; &gt; &gt; It's certainly not production ready, but it would be<br>
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
&gt; &gt; And no, "just pull" is not my default answer - if I<br>
&gt; &gt; don't have a reason, the default action is "don't<br>
&gt; &gt; pull".<br>
&gt; &gt;<br>
&gt; &gt; I used to say that "my job is to say 'no'", although<br>
&gt; &gt; I've been so good at farming out submaintainers that<br>
&gt; &gt; most of the time my real job is to pull from<br>
&gt; &gt; submaintainers who hopefully know how to say 'no'. But<br>
&gt; &gt; when it comes to whole new driver features, I'm still<br>
&gt; &gt; "no by default - tell me _why_ I should pull".<br>
&gt; &gt;<br>
&gt; &gt; So what is a new subsystem person to do?<br>
&gt; &gt;<br>
&gt; &gt; The best thing to do is to try to have users that are<br>
&gt; &gt; vocal about the feature, and talk about how great it<br>
&gt; &gt; is. Some advocates for it, in other words. Just a few<br>
&gt; &gt; other people saying "hey, I use this, it's great", is<br>
&gt; &gt; actually a big deal to me. For alacrityvm and cephfs, I<br>
&gt; &gt; didn't have that, or they just weren't loud enough for<br>
&gt; &gt; me to hear.<br>
&gt; &gt;<br>
&gt; &gt; So since you mentioned btrfs as an "early merge", I'll<br>
&gt; &gt; mention it too, as a great example of how something got<br>
&gt; &gt; merged early because it had easily gotten past my<br>
&gt; &gt; "people are asking for it" filter, to the point where<br>
&gt; &gt; _I_ was interested in trying it out personally, and<br>
&gt; &gt; asking Chris&amp;co to tell me when it was ready.<br>
&gt; &gt;<br>
&gt; &gt; Ok, so that was somewhat unusual - I'm not suggesting<br>
&gt; &gt; you'd need to try to drum up quite _that_ much hype -<br>
&gt; &gt; but it kind of illustrates the opposite extreme of your<br>
&gt; &gt; issue. Get some PR going, get people talking about it,<br>
&gt; &gt; get people testing it out. Get people outside of your<br>
&gt; &gt; area saying "hey, I use it, and I hate having to merge<br>
&gt; &gt; it every release".<br>
&gt; &gt;<br>
&gt; &gt; Then, when I see a pull request during the merge<br>
&gt; &gt; window, the pull suddenly has a much higher priority,<br>
&gt; &gt; and I go "Ok, I know people are using this".<br>
&gt; &gt;<br>
&gt; &gt; So no astro-turfing, but real grass-roots support<br>
&gt; &gt; really does help (or top-down feedback for that matter<br>
&gt; &gt; - if a _distribution_ says "we're going to merge this<br>
&gt; &gt; in our distro regardless", that also counts as a big<br>
&gt; &gt; hint for me that people actually expect to use it and<br>
&gt; &gt; would like to not go through the pain of merging).<br>
&gt; &gt;<br>
&gt; &gt; 			Linus<br>
&gt; &gt; --<br>
&gt; &gt; To unsubscribe from this list: send the line<br>
&gt; &gt; "unsubscribe linux-fsdevel" in the body of a message to<br>
&gt; &gt; majordomo@vger.kernel.org More majordomo info at <br>
&gt; &gt; http://vger.kernel.org/majordomo-info.html<br>
&gt;<br>
&gt; ---------------------------------------------------------<br>
&gt;--------------------- This SF.Net email is sponsored by<br>
&gt; the Verizon Developer Community Take advantage of<br>
&gt; Verizon's best-in-class app development support A<br>
&gt; streamlined, 14 day to market process makes app<br>
&gt; distribution fast and easy Join now and get one step<br>
&gt; closer to millions of Verizon customers<br>
&gt; http://p.sf.net/sfu/verizon-dev2dev<br>
&gt; _______________________________________________<br>
&gt; Ceph-devel mailing list<br>
&gt; Ceph-devel@lists.sourceforge.net<br>
&gt; https://lists.sourceforge.net/lists/listinfo/ceph-devel<br>
<p style="-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;"><br></p><p style="-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;"><br></p><p style="-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;"><br></p></body></html>
--Boundary-00=_AjFOLDXLHC88yUr--


--===============0553017729599606912==
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
--===============0553017729599606912==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ceph-devel mailing list
Ceph-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ceph-devel

--===============0553017729599606912==--
