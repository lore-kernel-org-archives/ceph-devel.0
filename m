From: Gregory Farnum <gfarnum@redhat.com>
Subject: Re: Memory Pooling and Containers
Date: Tue, 27 Sep 2016 16:00:46 -0700
Message-ID: <CAJ4mKGYQLrP_Z28iitj9Vwt3dSfVp2yQ3bnGt2jcTC9LahnvUg@mail.gmail.com>
References: <BLUPR0201MB1524456C8A99C6ABA036CBB9E8CC0@BLUPR0201MB1524.namprd02.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-it0-f52.google.com ([209.85.214.52]:34945 "EHLO
        mail-it0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753039AbcI0XAs (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 27 Sep 2016 19:00:48 -0400
Received: by mail-it0-f52.google.com with SMTP id r192so119545509ita.0
        for <ceph-devel@vger.kernel.org>; Tue, 27 Sep 2016 16:00:47 -0700 (PDT)
In-Reply-To: <BLUPR0201MB1524456C8A99C6ABA036CBB9E8CC0@BLUPR0201MB1524.namprd02.prod.outlook.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Allen Samuels <Allen.Samuels@sandisk.com>
Cc: Sage Weil <sage@newdream.net>, Ceph Development <ceph-devel@vger.kernel.org>

On Tue, Sep 27, 2016 at 1:30 PM, Allen Samuels
<Allen.Samuels@sandisk.com> wrote:
> As we discussed in the Bluestore standup this morning. This is intended to start a discussion about creating some internal memory pooling technology to try to get a better handle on the internal usage of memory by Ceph. Let's start by discussing the requirements...

I'm afraid I don't have any useful thoughts on this, but I'm curious
if there's any chance of using these memory pools effectively outside
of BlueStore. Many of the features you discuss would be nice in the
MDS, which currently uses boost::pool for some of its metadata types,
but could really use something with a little more control (at least
than we've set up so far).
-Greg
