From: Sage Weil <sage@newdream.net>
Subject: Re: MDS crash
Date: Tue, 24 May 2011 16:54:53 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1105241654290.9499@cobra.newdream.net>
References: <4DDACFF0.5060902@ufm.su>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:38982 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932094Ab1EXXxc (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 24 May 2011 19:53:32 -0400
In-Reply-To: <4DDACFF0.5060902@ufm.su>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Fyodor Ustinov <ufm@ufm.su>
Cc: ceph-devel@vger.kernel.org

On Tue, 24 May 2011, Fyodor Ustinov wrote:
> *** Caught signal (Segmentation fault) **
>  in thread 0x7f453ef81700
>  ceph version 0.28 (commit:071881d7e5599571e46bda17094bb4b48691e89a)
>  1: /usr/bin/cmds() [0x712c5e]
>  2: (()+0xfc60) [0x7f45411c0c60]
>  3: (MDCache::get_or_create_stray_dentry(CInode*)+0x25) [0x5356f5]
>  4: (Server::handle_client_unlink(MDRequest*)+0x997) [0x508857]
>  5: (Server::handle_client_request(MClientRequest*)+0x522) [0x520852]
>  6: (MDS::handle_deferrable_message(Message*)+0x9af) [0x4a266f]
>  7: (MDS::_dispatch(Message*)+0x173e) [0x4b617e]
>  8: (MDS::_dispatch(Message*)+0x427) [0x4b4e67]
>  9: (MDS::ms_dispatch(Message*)+0x59) [0x4b66c9]
>  10: (SimpleMessenger::dispatch_entry()+0x7ea) [0x4838aa]
>  11: (SimpleMessenger::DispatchThread::entry()+0x1c) [0x47b26c]
>  12: (()+0x6d8c) [0x7f45411b7d8c]
>  13: (clone()+0x6d) [0x7f454006a04d]

In case anyone else was seeing this problem, it's now fixed in the
stable branch.

sage
