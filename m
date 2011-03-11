From: Yehuda Sadeh Weinraub <yehudasa@gmail.com>
Subject: Re: cosd multi-second stalls cause "wrongly marked me down"
Date: Fri, 11 Mar 2011 11:17:29 -0800
Message-ID: <AANLkTi=jAofXcmVB1Be1AG67o4OyzuFxdS2iajwLDHGO@mail.gmail.com>
References: <1297891508.25491.120.camel@sale659.sandia.gov>
	<75157CFDA63D45458FC47FB7BA6CB974@gmail.com>
	<1297893011.25491.124.camel@sale659.sandia.gov>
	<Pine.LNX.4.64.1102161649560.11150@cobra.newdream.net>
	<Pine.LNX.4.64.1102161651380.11150@cobra.newdream.net>
	<1297957574.25491.152.camel@sale659.sandia.gov>
	<Pine.LNX.4.64.1102170805080.22514@cobra.newdream.net>
	<1297985503.25491.175.camel@sale659.sandia.gov>
	<1299686572.4750.329.camel@sale659.sandia.gov>
	<2E7A0FAAE7EA416896A1990C7A96D59A@gmail.com>
	<1299695809.4750.346.camel@sale659.sandia.gov>
	<144B52A5BA504DCB992CD253287A397A@gmail.com>
	<1299798589.4750.372.camel@sale659.sandia.gov>
	<Pine.LNX.4.64.1103101515430.20133@cobra.newdream.net>
	<1299799936.4750.378.camel@sale659.sandia.gov>
	<Pine.LNX.4.64.1103101538100.20133@cobra.newdream.net>
	<1299867988.4750.394.camel@sale659.sandia.gov>
	<Pine.LNX.4.64.1103111036450.23902@cobra.newdream.net>
	<1299869475.4750.405.camel@sale659.sandia.gov>
	<114FA4806BC54AAB9A6304BF5CF1A543@gmail.com>
	<AANLkTimrX=mkHvC_wf-rtCs7UiFYx04oc6EPp__u9D7j@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:43655 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751465Ab1CKTRa convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 11 Mar 2011 14:17:30 -0500
Received: by iwn34 with SMTP id 34so2931054iwn.19
        for <ceph-devel@vger.kernel.org>; Fri, 11 Mar 2011 11:17:30 -0800 (PST)
In-Reply-To: <AANLkTimrX=mkHvC_wf-rtCs7UiFYx04oc6EPp__u9D7j@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gregory.farnum@dreamhost.com>
Cc: Jim Schutt <jaschut@sandia.gov>, Sage Weil <sage@newdream.net>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Fri, Mar 11, 2011 at 11:13 AM, Yehuda Sadeh Weinraub
<yehudasa@gmail.com> wrote:
> On Fri, Mar 11, 2011 at 11:09 AM, Gregory Farnum
> <gregory.farnum@dreamhost.com> wrote:
>>>> =A0utime_t e =3D g_clock.now();
>>> =A0if (double(e - s) > 0.5) {
>>
>
> shouldn't that number be configurable?
>
oh, sorry.. it's just an output check.. forget it!
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
