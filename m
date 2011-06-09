From: Wido den Hollander <wido@widodh.nl>
Subject: Re: How to create new empty journal?
Date: Thu, 09 Jun 2011 12:09:05 +0200
Message-ID: <1307614145.2906.2.camel@wido-desktop>
References: <4DEFF804.9010606@ufm.su>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp02.mail.pcextreme.nl ([109.72.87.138]:60269 "EHLO
	smtp02.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752447Ab1FIKJI (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 9 Jun 2011 06:09:08 -0400
In-Reply-To: <4DEFF804.9010606@ufm.su>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Fyodor Ustinov <ufm@ufm.su>
Cc: ceph-devel@vger.kernel.org

Hi,

On Thu, 2011-06-09 at 01:30 +0300, Fyodor Ustinov wrote:
> Hi!
> 
> I need to create new fresh journal for OSD server without removing data.
> How?

This can be done with:

$ cosd -i <osdnum> -c /etc/ceph/ceph.conf --mkjournal

This will reset your journal.

Why do you want to do this?

Wido 

> 
> WBR,
>      Fyodor.
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


