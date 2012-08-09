From: Tommi Virtanen <tv@inktank.com>
Subject: Re: "no key for auth" when running "auth export mon. -o /tmp/monkey"?
Date: Thu, 9 Aug 2012 12:30:25 -0700
Message-ID: <CADvuQRHW-TmGpUhUYd_eU29C+6DRftAgSoV_CfQ+GCfpz6zT_w@mail.gmail.com>
References: <CADXA5U0m-PXRnZJhN83+HQ6uZXiM76A+ZD=q2JdrUD_8-q0Gmg@mail.gmail.com>
 <CADvuQRG=3bX0L2BfTpnQkv3S8OvnZ2qo8uf0ezvta0MYZmzSiQ@mail.gmail.com> <CADXA5U1eCkv+vrRz-YixBGiUVuQVksn-HwW9NDLG0spGx6Sfgg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vb0-f46.google.com ([209.85.212.46]:39794 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759376Ab2HITaq (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 9 Aug 2012 15:30:46 -0400
Received: by vbbff1 with SMTP id ff1so339088vbb.19
        for <ceph-devel@vger.kernel.org>; Thu, 09 Aug 2012 12:30:45 -0700 (PDT)
In-Reply-To: <CADXA5U1eCkv+vrRz-YixBGiUVuQVksn-HwW9NDLG0spGx6Sfgg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Matthew Roy <imjustmatthew@gmail.com>
Cc: John Wilkins <john.wilkins@inktank.com>, ceph-devel@vger.kernel.org

On Mon, Aug 6, 2012 at 2:07 PM, Matthew Roy <imjustmatthew@gmail.com> wrote:
> On Mon, Aug 6, 2012 at 11:55 AM, Tommi Virtanen <tv@inktank.com> wrote:
>> Do you have the file "keyring" in your
>> mon data dir, and does it contain a [mon.] section? If so, that
>> section is what you need in /tmp/monkey. If you're going by defaults,
>> there should be no other section in the file, and you can use the file
>> as-is.
>
> Yes, and that worked to initialize the new monitor.

For the record, this is being tracked at http://tracker.newdream.net/issues/2924
