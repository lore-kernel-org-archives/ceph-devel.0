From: Colin McCabe <cmccabe@alumni.cmu.edu>
Subject: Re: question about socket conection among osd,mds,mon
Date: Mon, 14 Feb 2011 02:21:20 -0800
Message-ID: <AANLkTikW4cmB5pDKGk=_W49NhTkgmY-0eP0ZGtfEWf=d@mail.gmail.com>
References: <4D57DFFB.5080703@nadir-seen-fire.com>
	<Pine.LNX.4.64.1102131028450.27567@cobra.newdream.net>
	<D0C67741759ABD4BBD8D3A5CB815606E07E935@mail.cloud-valley.com.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:36443 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752997Ab1BNKVV convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 14 Feb 2011 05:21:21 -0500
Received: by fxm20 with SMTP id 20so4995045fxm.19
        for <ceph-devel@vger.kernel.org>; Mon, 14 Feb 2011 02:21:20 -0800 (PST)
In-Reply-To: <D0C67741759ABD4BBD8D3A5CB815606E07E935@mail.cloud-valley.com.cn>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Longguang Yue <longguang_yue@tcloudcomputing.com>
Cc: Sage Weil <sage@newdream.net>, ceph-devel@vger.kernel.org

Hi Longguang,

The blacklist stops MDSes from talking to OSDs. You cannot blacklist
an OSD itself.

What is it that you're trying to do?

sincerely,
Colin


On Sun, Feb 13, 2011 at 7:13 PM, Longguang Yue
<longguang_yue@tcloudcomputing.com> wrote:
> 1.Netstat info:
> 10.10.1.100:6800 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0<--- 10.10.1.106:3458=
5, 10.10.1.98:46625
> 10.10.1.100:6801 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0<--- 10.10.1.106:5928=
4, 10.10.1.98:35101
> When osd need 2(more) listen sockets? Why =A0others osd connect as ma=
ny
> times as its listen socket?
>
>
> 2.how to deal with blacklist osds
> osd e35: 3 osds: 3 up, 3 in -- 2 blacklisted MDSes
>
> according to 1 case, how to deal with blacklist.
> If I need =A0run =A0'ceph osd blacklist rm =A010.10.1.106:34585 &&
> 10.10.1.98:46625 ' ??????
>
> I think just only one osd listen socket exists!!!!!!
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
