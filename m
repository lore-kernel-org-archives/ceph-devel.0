From: Matt Benjamin <mbenjamin@redhat.com>
Subject: Re: master build failure with boost 1.60
Date: Mon, 7 Mar 2016 14:56:43 -0500 (EST)
Message-ID: <1897896272.61850279.1457380603124.JavaMail.zimbra@redhat.com>
References: <20160307144944.GA21590@pxe-sup5.sup.suse.de> <56DDB0B0.2090005@suse.com> <CAANLjFqR2TDcuCQh=Avo5UyDNskjStPt5o_Jk3ehJ4Bhug1whg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx6-phx2.redhat.com ([209.132.183.39]:51627 "EHLO
	mx6-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753482AbcCGT46 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 7 Mar 2016 14:56:58 -0500
In-Reply-To: <CAANLjFqR2TDcuCQh=Avo5UyDNskjStPt5o_Jk3ehJ4Bhug1whg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Robert LeBlanc <robert@leblancnet.us>
Cc: Abhishek Lekshmanan <abhishek@suse.com>, ceph-devel <ceph-devel@vger.kernel.org>

Hi Robert,

What were you unable to do with Boost intrusive avl_set/rbtree/avltree in versions below 1.6?

Matt

----- Original Message -----
> From: "Robert LeBlanc" <robert@leblancnet.us>
> To: "Abhishek Lekshmanan" <abhishek@suse.com>
> Cc: "ceph-devel" <ceph-devel@vger.kernel.org>
> Sent: Monday, March 7, 2016 12:31:22 PM
> Subject: Re: master build failure with boost 1.60
> 
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA256
> 
> If we use boost 1.60, we can use intrusive maps which would be a lot
> easier in that code. I had to not use them to keep compatibility with
> older versions. I'm surprised that it is broken in newer versions.
> I'll see if I can figure out what is going wrong here.
> -----BEGIN PGP SIGNATURE-----
> Version: Mailvelope v1.3.6
> Comment: https://www.mailvelope.com
> 
> wsFcBAEBCAAQBQJW3brlCRDmVDuy+mK58QAAUkEQAK29Zc6W3IgBung03c1T
> md86mP1i6uBqyA4oFTmM4r4CF5dCQRrrAHXSd/1cM9bcvFmsir1LAjEalKaP
> f8P+lOPbHE8InQBe1b/pcS9vC2CaK8QeceONJBaEzlqwMaGFsIIFvlUd38jf
> 7Az/GlfRL+34LxAnShXQQJNTy8U7qqGp4ugRZSVPz9QaZDOayArfv3mlwzpD
> rzmXDWeq4JqGhtKdwlWiGdB6EF7t9BdbFzYFCcUyJ5v9G3kTMQJ7ROnv4Zu2
> ZoPVKcQ0wnjwxQSZVLGnvw1sYHeO9vUItqaMDl3RjpQrjXx25FpNY/9NrInT
> b14V/yEaDVyK1y85a2nLTwVVkRPq8GMXIJtvkCSV5sS2Zoo8Y85sX8SAL6qq
> y/hn4Uq73T+CBGq3Gy6Key7VnvzGcq9EvVw+3UnMkaxdyZOAQy/ly0lYLjpF
> SBw51h9ExPpl0pRACkkoa+64NeAlej3Zqk2c2EgB4+WGjuUhdSMxSmSmhLDw
> +VYQhz/GMHB+M7AkNIW9Cgo/muCM5jbhkU6wbHB6fKvohpA23UwWXBsK6AU+
> xjWJw0PuSYwpUsKYoD/U4F0YUDM39CQC6qpP1iCeVeptiuKzg7JWi0jh7myN
> mkuSjPo90ypaLa3kioX69Hr9BcCTTZ82wMjn44A5e3PV8Tvict2CYmCua57U
> Stp2
> =DdLX
> -----END PGP SIGNATURE-----
> ----------------
> Robert LeBlanc
> PGP Fingerprint 79A2 9CA4 6CC4 45DD A904  C70E E654 3BB2 FA62 B9F1
> 
> 
> On Mon, Mar 7, 2016 at 9:47 AM, Abhishek Lekshmanan <abhishek@suse.com>
> wrote:
> >
> >
> > On 03/07/2016 03:49 PM, Karol Mroz wrote:
> >> Hi folks,
> >>
> >> We've recently hit a build failure on ceph master for which Abhishek has
> >> opened
> >> a bug: http://tracker.ceph.com/issues/14998.
> >>
> >> Our rolling distribution (openSUSE Tumbleweed) has pushed out boost 1.60
> >> which looks to be at the heart of the failure. Is boost 1.60 to be
> >> supported in
> >> Jewel?
> >
> > Reverting https://github.com/ceph/ceph/pull/7654 makes the build
> > succeed, of course that is not the solution, but might indicate where we
> > may need fixing
> >
> > Regards
> > Abhishek
> >
> >> Thanks!
> >>
> >
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

-- 
Matt Benjamin
Red Hat, Inc.
315 West Huron Street, Suite 140A
Ann Arbor, Michigan 48103

http://www.redhat.com/en/technologies/storage

tel.  734-707-0660
fax.  734-769-8938
cel.  734-216-5309
