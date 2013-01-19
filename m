From: Dimitri Maziuk <dmaziuk@bmrb.wisc.edu>
Subject: Re: Understanding Ceph
Date: Sat, 19 Jan 2013 10:26:20 -0600
Message-ID: <50FAC92C.8030709@bmrb.wisc.edu>
References: <CAPrNTukzeSN8ZfO_Mhtx9LkHqe0M3tUxJuQG=gwwJD4w+-OGEg@mail.gmail.com>
Reply-To: dmaziuk@bmrb.wisc.edu
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cowfish.bmrb.wisc.edu ([144.92.167.220]:57773 "EHLO
	mail.bmrb.wisc.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751863Ab3ASQ0k (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 19 Jan 2013 11:26:40 -0500
In-Reply-To: <CAPrNTukzeSN8ZfO_Mhtx9LkHqe0M3tUxJuQG=gwwJD4w+-OGEg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Peter Smith <peterfruits@gmail.com>
Cc: ceph-devel@vger.kernel.org

On 1/19/2013 9:50 AM, Peter Smith wrote:

> 3. OS recommendation: The OS recommendation page:
> http://ceph.com/docs/master/install/os-recommendations/#bobtail-0-56
> says CentOS 6.3 has a default kernel with old kernel client. CentOS
> 6.3 is our production environment.

I was unable to get ceph to run on centos 6.3 following the "5 minute 
quick start" document. I did get one machine to "unclean" cluster state 
using elrepo's kernel 3.7, but that kernel doesn't boot on most of our 
boxen (boot-time oops in pata-acpi).

It looks to me that unless inktank backports rbd.ko to 2.6.32, centos/sl 
users won't be able to test ceph for a couple of years: until centos 7.1 
comes out and we get the chance to reimage our hardware.

Dima

