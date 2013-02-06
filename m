From: Gregory Farnum <greg@inktank.com>
Subject: Re: Increase number of pg in running system
Date: Tue, 5 Feb 2013 20:01:26 -0800
Message-ID: <635DC7BB13C0437E86BCEAF7D0FA86E9@inktank.com>
References: <CAD3n6hFb=m_PL27sWZ5BSBAYP3xmTGZS_DrL-4ozF2+JbndMCA@mail.gmail.com>
 <loom.20130205T153942-509@post.gmane.org>
 <CA+jddaN5zjDEhknDq2RCsTmXQUDbJB-VKV0K3JcT09Ai0Pdz=Q@mail.gmail.com>
 <alpine.DEB.2.00.1302051743380.19543@cobra.newdream.net>
 <6F3FA899187F0043BA1827A69DA2F7CC5EDF9D@SHSMSX102.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f41.google.com ([209.85.220.41]:35888 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755382Ab3BFEBa convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 5 Feb 2013 23:01:30 -0500
Received: by mail-pa0-f41.google.com with SMTP id fb11so550599pad.28
        for <ceph-devel@vger.kernel.org>; Tue, 05 Feb 2013 20:01:29 -0800 (PST)
In-Reply-To: <6F3FA899187F0043BA1827A69DA2F7CC5EDF9D@SHSMSX102.ccr.corp.intel.com>
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "=?utf-8?Q?ceph-devel=40vger.kernel.org?=" <ceph-devel@vger.kernel.org>
Cc: Sage Weil <sage@inktank.com>, =?utf-8?Q?Chen=2C_Xiaoxi?= <xiaoxi.chen@intel.com>, Mandell Degerness <mandell@pistoncloud.com>

On Tuesday, February 5, 2013 at 5:49 PM, Sage Weil wrote:
> On Tue, 5 Feb 2013, Mandell Degerness wrote:
> > I would like very much to specify pg_num and pgp_num for the defaul=
t
> > pools, but they are defaulting to 64 (no OSDs are defined in the
> > config file). I have tried using the options indicated by Artem, bu=
t
> > they didn't seem to have any effect on the data and rbd pools which
> > are created by default. Is there something I am missing?
> =20
> =20
> =20
> =20
> Ah, I see. Specifying this is awkward. In [mon] or [global],
> =20
> osd pg bits =3D N
> osd pgp bits =3D N
> =20
> where N is the the number of bits to shift 1 to the left. So for 1024
> PGs, you'd do 10. (What it's actually doing is MIN(1, num_osds) << N.
> The default N is 6, so you're probaby seeing 64 PGs per pool by defau=
lt.)

I see the confusion though =E2=80=94 the osd_pool_default_pg_num option=
 is only used for pools which you create through the monitor after the =
system is already running.



On Tuesday, February 5, 2013 at 7:22 PM, Chen, Xiaoxi wrote:

> But can we change the pg_num of a pool when the pool contains data? I=
f yes, how to do this? =20
> =20
We advise against that right now; the relevant code isn't well-enough t=
ested.
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
