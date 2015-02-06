From: Yehuda Sadeh-Weinraub <yehuda@redhat.com>
Subject: Re: civetweb upstream
Date: Fri, 6 Feb 2015 12:02:53 -0500 (EST)
Message-ID: <391658056.205926.1423242173510.JavaMail.zimbra@redhat.com>
References: <54D4DDAE.50604@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx5-phx2.redhat.com ([209.132.183.37]:46811 "EHLO
	mx5-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755539AbbBFRCz (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 6 Feb 2015 12:02:55 -0500
In-Reply-To: <54D4DDAE.50604@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ken Dreyer <kdreyer@redhat.com>
Cc: ceph-devel@vger.kernel.org



----- Original Message -----
> From: "Ken Dreyer" <kdreyer@redhat.com>
> To: ceph-devel@vger.kernel.org
> Sent: Friday, February 6, 2015 7:28:46 AM
> Subject: civetweb upstream
> 
> Hi folks,
> 
> It looks like Ceph has its own fork of the upstream civetweb project.
> What was the reason for forking at the time? Has there been much effort
> to get our civetweb changes upstream?
> 

The biggest motivation originally was to get it integrated into our automake system, as it was using weird suffixes for some include file. When civetweb was split out of mongoose, they made some changes to the code structure that made it harder to embed into our system. Later on there were some relatively minor changes and bug fixes. We might be able to push some upstream as is, and some might need to be reworked so that they'd make sense in that context.

Yehuda
