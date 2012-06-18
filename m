From: Tommi Virtanen <tv@inktank.com>
Subject: Re: iostat show constants write to osd disk with writeahead journal,
 normal behaviour ?
Date: Mon, 18 Jun 2012 09:01:52 -0700
Message-ID: <CADvuQREFunAWAzYUuN73LevBk3AwH-QsUu3rH6P1N5Fyu-TRKA@mail.gmail.com>
References: <9b922de7-7e17-4b9f-a388-c612b019627a@mailpro> <de0635df-9b2a-4848-89ed-8eda179147db@mailpro>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:36401 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753094Ab2FRQCN (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 18 Jun 2012 12:02:13 -0400
Received: by dady13 with SMTP id y13so7131606dad.19
        for <ceph-devel@vger.kernel.org>; Mon, 18 Jun 2012 09:02:12 -0700 (PDT)
In-Reply-To: <de0635df-9b2a-4848-89ed-8eda179147db@mailpro>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alexandre DERUMIER <aderumier@odiso.com>
Cc: ceph-devel@vger.kernel.org

On Mon, Jun 18, 2012 at 5:34 AM, Alexandre DERUMIER <aderumier@odiso.com> wrote:
> I'm doing test with rados bench, and I see constant writes to osd disks.
> Is it the normal behaviour ? with write-ahead should write occur each 20-30 seconde ?

Is the osd data filesystem perhaps doing atime updates? noatime is your friend.
