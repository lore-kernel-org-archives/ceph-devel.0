From: Fyodor Ustinov <ufm@ufm.su>
Subject: Re: looks like a bug
Date: Tue, 19 Jul 2011 17:39:36 +0300
Message-ID: <4E259728.8050908@ufm.su>
References: <4E254135.70603@ufm.su> <Pine.LNX.4.64.1107190729150.5656@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.ufm.su ([77.120.103.19]:60213 "EHLO mail.ufm.su"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750925Ab1GSOjj (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 19 Jul 2011 10:39:39 -0400
In-Reply-To: <Pine.LNX.4.64.1107190729150.5656@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel@vger.kernel.org

On 07/19/2011 05:31 PM, Sage Weil wrote:
> Hi Fyodor,
>
> Which commits are you running on the server and client side?  There was a
> bad protocol version number in master branch for several days (fixed now),
> and some open intent stuff in ceph-client.git that wasn't quite right a
> bit further back.
>
> thanks-
> sage

If I do not specify the version it means that I'm using the latest 
available official version for ubuntu from your aptitude repository.

WBR,
     Fyodor.
