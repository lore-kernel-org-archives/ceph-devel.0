From: Yehuda Sadeh-Weinraub <yehuda@redhat.com>
Subject: Re: rgw: bytes sent/received excludes headers
Date: Wed, 4 Feb 2015 11:34:27 -0500 (EST)
Message-ID: <2107719654.7307778.1423067667132.JavaMail.zimbra@redhat.com>
References: <622F4407872BA447A16110F65453358C037C20E05608@FMSAMAIL.fmsa.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx4-phx2.redhat.com ([209.132.183.25]:55852 "EHLO
	mx4-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966671AbbBDQea (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 4 Feb 2015 11:34:30 -0500
In-Reply-To: <622F4407872BA447A16110F65453358C037C20E05608@FMSAMAIL.fmsa.local>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Paul Von-Stamwitz <PVonStamwitz@us.fujitsu.com>
Cc: ceph-devel@vger.kernel.org


> 
> Hi,
> 
> It is my impression that bytes_sent and bytes_received do not include
> headers. We got a request from a customer who wants to include them (I
> know... greedy.) Is there a way to calculate the amount of header
> information that was transferred?
> 

There's no easy way to do it from the gateway itself. If going through fastcgi then the actual received and sent headers are modified. We could do some estimation, but it just wouldn't be accurate.
Another way to go would be to do some kind of post processing on the web server logs.

Yehuda
