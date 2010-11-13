From: Gregory Farnum <gregf@hq.newdream.net>
Subject: Re: How can I change max_mds on v0.23?
Date: Sat, 13 Nov 2010 08:46:36 -0800
Message-ID: <AANLkTi=ayd25yVpvFqBYsdAOj2vCHqAo_Ambm50srvve@mail.gmail.com>
References: <7F0CB039-816F-4252-9961-EF638EC40286@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:58662 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932068Ab0KMQqi (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 13 Nov 2010 11:46:38 -0500
Received: by eye27 with SMTP id 27so2429081eye.19
        for <ceph-devel@vger.kernel.org>; Sat, 13 Nov 2010 08:46:37 -0800 (PST)
In-Reply-To: <7F0CB039-816F-4252-9961-EF638EC40286@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tatsuya Kawano <tatsuya6502@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Sat, Nov 13, 2010 at 7:57 AM, Tatsuya Kawano <tatsuya6502@gmail.com> wrote:
>
> Hi,
>
> I want to try out clustered MDS on v0.23. I followed the Wiki at <http://ceph.newdream.net/wiki/MDS_cluster_expansion>
> and tried to set max_mds to 2, but Ceph doesn't recognize the command.
>
> ceph@cepha3:~$ ceph mds set max_mds 2
> 2010-11-14 00:44:03.008148 mon <- [mds,set,max_mds,2]
> 2010-11-14 00:44:03.009006 mon0 -> 'unrecognized command' (-22)
"ceph mds set_max_mds 2"
Note the underscore, so that "set_max_mds" is a single word for the
parser. I've fixed it in the wiki. :)
-Greg
