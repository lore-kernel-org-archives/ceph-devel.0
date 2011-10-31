From: mowang da <whooya.xxl@gmail.com>
Subject: Re: ping_pong test of ceph
Date: Mon, 31 Oct 2011 10:18:56 +0800
Message-ID: <CAMwsgzM5O1Xx+5WdufJdSUj1g500X36D0mtJizWF+aOSg4vr_w@mail.gmail.com>
References: <CAMwsgzPBzcwnJTkhDPAanQemwUirHe-yTHVHE4hMpjc4sgVkKw@mail.gmail.com>
	<CAF3hT9BEhwGVeiud0fDmBscB2KKc1uAJxvAEGQZ2KAW6pWOhTg@mail.gmail.com>
	<CAMwsgzNkgd0gYf_LNELWfB8Fd5e7HP0v=R8wgAOG8jkEXUxG9A@mail.gmail.com>
	<CAF3hT9CkNdi4UFgAPhqy9xzk8s_7Tz6bqG5aTW3k87oxfEEt7g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:43407 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753524Ab1JaCS6 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 30 Oct 2011 22:18:58 -0400
Received: by bkbzt4 with SMTP id zt4so1736643bkb.19
        for <ceph-devel@vger.kernel.org>; Sun, 30 Oct 2011 19:18:56 -0700 (PDT)
In-Reply-To: <CAF3hT9CkNdi4UFgAPhqy9xzk8s_7Tz6bqG5aTW3k87oxfEEt7g@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

thanks , if there is only one client, can we use local flock to
replace flock mds?

2011/10/31 Gregory Farnum <gregory.farnum@dreamhost.com>:
> On Sun, Oct 30, 2011 at 6:21 PM, mowang da <whooya.xxl@gmail.com> wrote:
>> hi all,
>> this bug has been fixed yet? i can't find any information of it.
>> thanks for your help.
>
> Yes, it was fixed a while ago in our master branch and is fixed in our
> last couple of releases. (Our newest is v0.37.)
> As the problem was in the MDS server, to see this fix you only need to
> upgrade the userspace packages. :)
> -Greg
>
