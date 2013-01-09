From: Mark Kampe <mark.kampe@inktank.com>
Subject: Re: geo replication
Date: Wed, 09 Jan 2013 13:32:03 -0800
Message-ID: <50EDE1D3.3080803@inktank.com>
References: <CAJH6TXjnUTdjwi-dW6kV-2WEf58-B=gx1ubnep30x_0Td5JHTw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f49.google.com ([209.85.160.49]:34779 "EHLO
	mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933329Ab3AIVcE (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 9 Jan 2013 16:32:04 -0500
Received: by mail-pb0-f49.google.com with SMTP id un15so1191800pbc.22
        for <ceph-devel@vger.kernel.org>; Wed, 09 Jan 2013 13:32:04 -0800 (PST)
In-Reply-To: <CAJH6TXjnUTdjwi-dW6kV-2WEf58-B=gx1ubnep30x_0Td5JHTw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gandalf Corvotempesta <gandalf.corvotempesta@gmail.com>
Cc: ceph-devel@vger.kernel.org

Right now, your only option is synchronous replication, which
happens at the speed of the slowest OSD ... so unless your
WAN links are fast and fat, it comes at non-negligible
performance penalty.

We will soon be sending out a proposal for an asynchronous
replication mechanism with eventual consistency for the
RADOS Gateway ... but that is a somewhat simpler problem
(immutable objects, good change lists, and a WAN friendly
protocol).

Asynchronous RADOS replication is definitely on our list,
but more complex and farther out.

On 01/09/2013 01:19 PM, Gandalf Corvotempesta wrote:
> probably this was already asked before but i'm unable to find any answer.
> Is possible to replicate a cluster geografically?
>
> GlusterFS does this with rsync (i think called automatically on every
> file write), does cheph do something similiar?
>
> I don't think that using multiple geographically distributed OSD with
> 10-15ms of latency will be good
