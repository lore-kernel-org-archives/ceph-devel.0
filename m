From: Vasilakakos Giorgos <sugoruyo@gmail.com>
Subject: Question: How does Ceph go from filename to object?
Date: Mon, 4 Jul 2011 20:17:58 +0300
Message-ID: <CANJmCG+HZWWnEmpJ+pY4fjweBckRMPh+b6OiD=kk1egwT9B3=Q@mail.gmail.com>
References: <CANJmCGLt2hPjETaa5bGt71Ewyo4Z-q6XXYsegRUAZNZb-h7J3A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:41512 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753816Ab1GDRSj (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 4 Jul 2011 13:18:39 -0400
Received: by qwk3 with SMTP id 3so2527769qwk.19
        for <ceph-devel@vger.kernel.org>; Mon, 04 Jul 2011 10:18:38 -0700 (PDT)
In-Reply-To: <CANJmCGLt2hPjETaa5bGt71Ewyo4Z-q6XXYsegRUAZNZb-h7J3A@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hello folks, I have a question:
I know files get mapped to objects and those objects to OSDs but how
exactly do we go from one to the other?
What I mean is, given the filename I want to access how does Ceph find
the relevant objects? What exactly does CRUSH do?
Supposedly, the client first asks the MDS for an inode number, what then?
How are the object and PG IDs constructed and where exactly does CRUSH come in?
My impression is that the OID is made from the name, inode and
probably some kind of information about the striping of the file,
what about the mapping of an object to a PG?
Are PGs mapped to OSDs by means of CRUSH, or are objects mapped to PGs
by CRUSH? How are PGs assigned to OSDs then?

Could someone clarify this part for me?

Thanks in advance
