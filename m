From: Gregory Farnum <gfarnum@redhat.com>
Subject: =?UTF-8?Q?Re=3A_why_clog_can_redirect_to_mon=EF=BC=9F?=
Date: Mon, 8 Aug 2016 16:28:23 -0700
Message-ID: <CAJ4mKGZiAVp1S4O+ggstc_Lxh7Eda_Gi9_7Zuv-DJ1bQZZhsUw@mail.gmail.com>
References: <CAKZcxgc95-dGB=CCnvXe__rz9SpWzDGUkpR327x-OgnKExKZ2w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ua0-f171.google.com ([209.85.217.171]:34101 "EHLO
	mail-ua0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751652AbcHHXeS convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 8 Aug 2016 19:34:18 -0400
Received: by mail-ua0-f171.google.com with SMTP id 35so277673201uap.1
        for <ceph-devel@vger.kernel.org>; Mon, 08 Aug 2016 16:34:18 -0700 (PDT)
In-Reply-To: <CAKZcxgc95-dGB=CCnvXe__rz9SpWzDGUkpR327x-OgnKExKZ2w@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jaze Lee <jazeltq@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Mon, Aug 8, 2016 at 6:35 AM, Jaze Lee <jazeltq@gmail.com> wrote:
> Hi all，
>
>       I found that clog default send message to mon. But i do not know why it
> sends to mon? Can someone explian more about why we do that ?

The purpose of the "central log" is to send log messages to a central
location for sharing. The mon is what we've got right now; it collects
the messages, writes them to a local file, and spits them out to
anybody running "ceph -w" (technically, anybody with a log
subscription).
-Greg
