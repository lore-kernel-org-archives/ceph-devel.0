From: Nulik Nol <nuliknol@gmail.com>
Subject: app design recommendations
Date: Tue, 20 Aug 2013 15:06:42 -0500
Message-ID: <CAHO6xe-FSmZdFTqDq56U9_QQ_hoPMnPqbFLjT1CLGETz-hCs7A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ea0-f194.google.com ([209.85.215.194]:37833 "EHLO
	mail-ea0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751870Ab3HTVA5 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 20 Aug 2013 17:00:57 -0400
Received: by mail-ea0-f194.google.com with SMTP id q16so261197ead.9
        for <ceph-devel@vger.kernel.org>; Tue, 20 Aug 2013 14:00:56 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi,
I am creating an email system which will handle whole company's email,
mostly internal mail. There will be thousands of companies and
hundreds of users per company. So I am planning to use one pool per
company to store email messages. Can Ceph manage thousands or maybe
hundred thousands of pools ? Could there be any slowdown at production
with such design after some growth?

Every email will be stored as an individual ceph object (emails will
average 512 bytes and rarely have attachments) , is it ok to store
them as a ceph objects or will it be less efficient than storing
multiple emails in a ceph object,? What is the optimal ceph object
size to store individually, so it would be preferable to do this
instead of writing through omap with leveldb? (kind of "ceph object vs
omap" benchmark question)

Also I will be putting mini-chat sessions between users in a ceph
object, each time a user sends a message to another user, I will
append the text to the ceph object, so my question is, will Ceph
rewrite the whole object into a new physical location on disk when I
do an append? Or will it just rewrite the block that was modified?

And last questions: Which is faster, storing small key/value pairs in
omap or in xattrs ? Will storing key/value pairs in xattrs result in
space waste by allocating a block for zero-sized object on the OSD? (I
won't write any data to the object, just use xattrs)

Will appreciate very much your comments.

Best Regards
Nulik
