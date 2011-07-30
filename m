From: Fyodor Ustinov <ufm@ufm.su>
Subject: Re: Kernel 3.0.0 + ext4 + ceph == ...
Date: Sat, 30 Jul 2011 20:54:59 +0300
Message-ID: <4E344573.8060404@ufm.su>
References: <4E33D101.1050504@ufm.su>	<9BF9E529-C532-4A94-8362-93C2D1B778DB@mit.edu> <4E3432FC.9030204@ufm.su>	<20110730165001.GI7361@thunk.org> <Pine.LNX.4.64.1107301016120.23447@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.ufm.su ([77.120.103.19]:42231 "EHLO mail.ufm.su"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751374Ab1G3RzC (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sat, 30 Jul 2011 13:55:02 -0400
In-Reply-To: <Pine.LNX.4.64.1107301016120.23447@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Ted Ts'o <tytso@mit.edu>, ceph-devel@vger.kernel.org

On 07/30/2011 08:21 PM, Sage Weil wrote:
>
> Fyodor, if you set 'debug filestore = 10' you'll get a log of every
> operation on the fs in the osd log.  (Or close to it; there may be a few
> that we missed, but to a first approximation at least it'll describe the
> workload pretty well.)
>
Well, I do it. No need to wait for complete synchronisation.

Who wants to get this small file? :)

-rw------- 1 root root 412M 2011-07-30 20:51 /var/log/ceph/osd.0.log

WBR,
     Fyodor.

