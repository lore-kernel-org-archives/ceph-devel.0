From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: Osd magic detection failure in master
Date: Mon, 02 Dec 2013 18:47:23 -0800
Message-ID: <529D463B.4040601@inktank.com>
References: <529D4528.3050901@catalyst.net.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yh0-f51.google.com ([209.85.213.51]:43334 "EHLO
	mail-yh0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753805Ab3LCCrf (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 2 Dec 2013 21:47:35 -0500
Received: by mail-yh0-f51.google.com with SMTP id c41so8142983yho.38
        for <ceph-devel@vger.kernel.org>; Mon, 02 Dec 2013 18:47:34 -0800 (PST)
In-Reply-To: <529D4528.3050901@catalyst.net.nz>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Kirkwood <mark.kirkwood@catalyst.net.nz>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 12/02/2013 06:42 PM, Mark Kirkwood wrote:
> I just updated master (a5eda4fcc34461dbc0fcc47448f8456097de15eb), and am
> seeing OSDs failing to start:
>
> 2013-12-03 15:37:01.291200 7f488e1157c0 -1 OSD magic  != my ceph osd
> volume v026
> failed: 'ulimit -n 32768;  /usr/bin/ceph-osd -i 0 --pid-file
> /var/run/ceph/osd.0.pid -c /etc/ceph/ceph.conf '
>
> Now it appears that the magic is not being read. It is however there and
> seemingly ok:
>
> $ cat /var/lib/ceph/osd/ceph-0/magic
> ceph osd volume v026
>
> Looking at src/osd/OSD.cc I wonder if something like this is needed (as
> it seems that magic is being assigned to an empty val otherwise):

Exactly, I merged the same fix independently a little while ago.

> --- a/src/osd/OSD.cc
> +++ b/src/osd/OSD.cc
> @@ -731,7 +731,7 @@ int OSD::peek_meta(ObjectStore *store, std::string&
> magic,
>   {
>     string val;
>
> -  int r = store->read_meta("magic", &magic);
> +  int r = store->read_meta("magic", &val);
>     if (r < 0)
>       return r;
>     magic = val;
>
>
> This makes the osd's start ok, but the mon does not detect  them
> (possibly another issue or my patch is wrong). I'll keep looking :-)

Not sure what's going on here yet, as the boot message is sent and
received.
