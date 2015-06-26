From: Pete Zaitcev <zaitcev@redhat.com>
Subject: Re: What is omap
Date: Fri, 26 Jun 2015 13:02:22 -0600
Message-ID: <20150626130222.42af4404@guren.zaitcev.lan>
References: <20150624234728.79c29b49@guren.zaitcev.lan>
	<CAJY_B6RCA+3s3r+7B=s8pYomrrnTscSsd77PSL8QsJFbeOG6jQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:38711 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751969AbbFZTCZ (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 26 Jun 2015 15:02:25 -0400
In-Reply-To: <CAJY_B6RCA+3s3r+7B=s8pYomrrnTscSsd77PSL8QsJFbeOG6jQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@gregs42.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Fri, 26 Jun 2015 14:48:15 +0100
Gregory Farnum <greg@gregs42.com> wrote:

> Each object consists of three different data storage areas, all of
> which are 100% optional: the "bundle of bits" object data, the object
> xattrs, and the object omap key-value store.

Thanks for the explanation. This was unexpected. I thought an object had
one K/V namespace associated with it, with xattrs and omap being two
implementations of it, switcheable depending on OSD configuration.

> Each OSD has its *own* local leveldb where all that data
> goes; there's no cross-OSD LevelDB replication or communication.

Okay, that makes sense.

So, do I understand right that we don't have a document that
explains the above? All I want to write is "the list of buckets
is kept in omap of object such and such; see URL FOO for explanation
of omap".

-- Pete
