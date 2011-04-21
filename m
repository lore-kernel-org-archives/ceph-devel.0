From: Brian Chrisman <brchrisman@gmail.com>
Subject: Re: libceph API
Date: Thu, 21 Apr 2011 07:43:23 -0700
Message-ID: <BANLkTimmm5mgRTAxQPBaeTDmv=CoL3g78w@mail.gmail.com>
References: <BANLkTim22eFcMzxL0sB4GRpUZfu7FL3x4A@mail.gmail.com>
	<Pine.LNX.4.64.1104202200100.26241@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:45768 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754100Ab1DUOnY convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 21 Apr 2011 10:43:24 -0400
Received: by vxi39 with SMTP id 39so1252608vxi.19
        for <ceph-devel@vger.kernel.org>; Thu, 21 Apr 2011 07:43:23 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.1104202200100.26241@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Colin McCabe <cmccabe@alumni.cmu.edu>, ceph-devel@vger.kernel.org

On Wed, Apr 20, 2011 at 10:03 PM, Sage Weil <sage@newdream.net> wrote:
> On Wed, 20 Apr 2011, Colin McCabe wrote:
>> Hi guys,
>>
>> I pushed a branch with a revised libceph API. The main changes:
>>
>> * similar appearance to librados. It should be intuitive if you've
>> used librados.
>> * The new API allows multiple ceph clusters to be open at once
>> (although the implementation doesn't support this yet)
>> * ability to pass a "root" argument to ceph_mount
>> * add support for reading configuration files and choosing whether t=
o parse argv
>> * simpler ceph_getcwd
>> * unmount can't fail (the library always cleans up after itself)
>>
>> The branch is at
>> http://ceph.newdream.net/git/?p=3Dceph.git;a=3Dshortlog;h=3Drefs/hea=
ds/libceph_api
>>
>> Let me know what you think!
>
> Can we combine the ceph_connect() and ceph_mount() into one thing? =A0=
Does
> that make sense? =A0If so, maybe it should be ceph_mount_t and not
> ceph_cluster_t or something.
>
> The (re/ab)use of DIR* was possibly not the wisest choice in the orig=
inal
> API (and Client.h for that matter?). =A0Now might be the time to use =
a more
> reasonably named typedef.
>
> A few of the methods can probably go away (things like ceph_mkdirs) o=
r be
> cleaned up (the layout get/set stuff).
>
> Otherwise looks good! =A0Brian?
>
> sage
>

Looks good.  The implicit state in the library seemed like a fairly
good fit for the vfs stuff, but shouldn't be a problem to create,
store, and pass that explicitly.
I'm not certain what other libceph applications will require access to
multiple ceph filesystems, but something like a replication program
comes to mind most immediately.
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
