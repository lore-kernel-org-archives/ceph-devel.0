From: Josh Durgin <josh.durgin@dreamhost.com>
Subject: Re: mkcephfs giving problems
Date: Thu, 15 Sep 2011 10:07:12 -0700
Message-ID: <4E7230C0.4090600@dreamhost.com>
References: <loom.20110915T081127-706@post.gmane.org>	 <1316086135.3104.4.camel@wido-desktop>	 <CAMiHsJLTR=rvoND829mE_AsZqAhY4jAAu60QtHQFepg5E8a9Rg@mail.gmail.com> <1316088088.3104.10.camel@wido-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:60618 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751628Ab1IORHN (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 15 Sep 2011 13:07:13 -0400
In-Reply-To: <1316088088.3104.10.camel@wido-desktop>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Atish Kathpal <atish.kathpal@gmail.com>

 >> failed: AdminSocket::bind_and_listen: failed to bind the UNIX domain
 >> socket to '/var/run/ceph/osd.0.asok': error 2: No such file or
 >> directory

Do the /var/run/ceph and /ceph_data/osd.0 directories exist?
