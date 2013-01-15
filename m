From: Wido den Hollander <wido@widodh.nl>
Subject: Re: Rack Awareness
Date: Tue, 15 Jan 2013 11:59:39 +0100
Message-ID: <50F5369B.10601@widodh.nl>
References: <CAJH6TXiCxyqb877HiCpj7uLpiBUPjAL5sPxrMnd1n1fXub85pg@mail.gmail.com> <50F52E4C.4000704@widodh.nl> <CAJH6TXj96-OSbR+8MrS7o4bjzcC-zj=2z88sE=6TWzvadHNTTg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp01.mail.pcextreme.nl ([109.72.87.137]:45749 "EHLO
	smtp01.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750872Ab3AOK7m (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 15 Jan 2013 05:59:42 -0500
In-Reply-To: <CAJH6TXj96-OSbR+8MrS7o4bjzcC-zj=2z88sE=6TWzvadHNTTg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gandalf Corvotempesta <gandalf.corvotempesta@gmail.com>
Cc: ceph-devel@vger.kernel.org

On 01/15/2013 11:34 AM, Gandalf Corvotempesta wrote:
> 2013/1/15 Wido den Hollander <wido@widodh.nl>:
>> Yes, no problem at all! That's where the crushmap is for. This way you can
>> tell Ceph exactly how to distribute your data.
>
> Cool.
> If I understood properly, I have to configure ceph with OSD in a
> standard way and then
> map these osd into a custom crushmap like this:
>
> host node1 {
>          id -1
>          alg straw
>          hash 0
>          item osd.0 weight 1.00
>          item osd.1 weight 1.00
> }
>
> host node2 {
>          id -2
>          alg straw
>          hash 0
>          item osd.2 weight 1.00
>          item osd.3 weight 1.00
> }
>
> rack rack1 {
>          id -3
>          alg straw
>          hash 0
>          item node1 weight 2.00
> }
>
> rack rack2 {
>          id -4
>          alg straw
>          hash 0
>          item node2 weight 2.00
> }
>
> This one should allow me to have 4 OSDs, 2 servers and 2 racks. Each
> rack with one server with 2 OSDs
> Data will be automatically striped across both rack, right?
>

Almost! A couple of things:

You don't have to sum the weight of a node in the rack, crush will sum 
the nodes automatically. If all nodes are equal there is no need to do so.


You need to add this as well:

root default {
         id -1
         alg straw
         hash 0
         item rack1
         item rack2
}

rule data {
         ruleset 0
         type replicated
         min_size 1
         max_size 10
         step take default
         step chooseleaf firstn 0 type rack
         step emit
}

You should know that you can never set replication higher then 2 with 
this setting since it always tries to pick a rack and you only have two.

Wido

