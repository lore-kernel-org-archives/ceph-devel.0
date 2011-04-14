From: huang jun <hjwsm1989@gmail.com>
Subject: can mds prepare inodes?
Date: Thu, 14 Apr 2011 17:46:32 +0800
Message-ID: <BANLkTiniJAbPZpbGZEpucN4O1sWQKvjyvQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:35265 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757922Ab1DNJqd (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 14 Apr 2011 05:46:33 -0400
Received: by vws1 with SMTP id 1so1140998vws.19
        for <ceph-devel@vger.kernel.org>; Thu, 14 Apr 2011 02:46:32 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

hi developers,
   I have a question about the prealloc_inos variable in SessionMap.h
   when the client first request to allocate an inode,
prepare_new_inode function will prepare new inodes to the session. so
if  the client's first request is to make a dir, the MDS always
return  a  safe message to the client, but why it  do not answer
unsafe to th client?
  i want to  prepare new inodes to the session in
handle_client_stat,can i do that? in other words, should i allocate
inodes when client mounted on the ceph cluster?
thanks!
