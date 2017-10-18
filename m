From: alan somers <asomers@gmail.com>
Subject: Re: Wish list : automatic rebuild with hot swap osd ?
Date: Wed, 18 Oct 2017 10:02:28 -0600
Message-ID: <CAOtMX2hcnqQT8R_qAkRrDwdE=+S_+wX9FqSTnLcAVyMmuSraJw@mail.gmail.com>
References: <06c8570a-415c-b830-3102-476a0d85cbdf@epfl.ch> <alpine.DEB.2.11.1710172118210.26702@piezo.us.to>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lf0-f43.google.com ([209.85.215.43]:51455 "EHLO
        mail-lf0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751728AbdJRQCa (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 18 Oct 2017 12:02:30 -0400
Received: by mail-lf0-f43.google.com with SMTP id r129so6398337lff.8
        for <ceph-devel@vger.kernel.org>; Wed, 18 Oct 2017 09:02:30 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.11.1710172118210.26702@piezo.us.to>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Yoann Moulin <yoann.moulin@epfl.ch>, ceph-devel <ceph-devel@vger.kernel.org>

On Tue, Oct 17, 2017 at 3:22 PM, Sage Weil <sage@newdream.net> wrote:
> On Tue, 17 Oct 2017, Yoann Moulin wrote:
>> Hello,
>>
>> I wonder if it's possible to add to ceph the ability to rebuild a new disk automatically freshly added to a slot in replacement of a failed osd
>> disk.
>>
>> I imagine something like adding a flag on disks (identified by-path for example or a way to have a deterministic access to the device) to be
>> auto-reconfigured if detected with no data after the same slot was marked as failed. Only disks identified "by-path" with an auto-rebuild flag
>> activated, and previously marked as failed, can run the auto-reconfiguration.
>>
>> I know it should take some time to find the best way to implement that feature to avoid zapping a disk with data but that would be great to
>> improve maintainability.
>
> The way that we approached this before with ceph-disk was that you would
> prelabel replacement disks as "blank ceph" or similar.  That way if we saw
> a ceph labeled disk that hadn't been used yet we would know it was fair
> game.  This is a lot more work for the admin (you have to attached each of
> your replacement disks to mark them and then put them in the replacement
> pile) but it is safer.
>
> An alternative model would be to have a reasonably reliable way to
> identify a fresh disk from the factory.  I'm honest not sure what new
> disks look like these days (zero? empty NTFS partition?) but we could try
> to recognized "blank" and go from there.
>
> Unfortunately we can't assume blank if we see garbage because the disk
> might be encrypted.
>
> Anyway, assuming that part was sorted out, I think a complete solution
> would query the mons to see what OSD id used to live in that particular
> by-path location/slot and try to re-use that OSD ID.  We have still built
> in a manual task here of marking the failed osd "destroyed" since reusing
> the ID means the cluster may make assumptions about PG copies on the OSD
> being lost.
>
> sage

ZFS handles this with the "autoreplace" pool flag.  If that flag is
set, then a blank drive inserted into a slot formerly occupied by a
member of the pool will automatically be used to replace that former
member.  The nice thing about this scheme is that it requires no
per-drive effort on the part of the sysadmin, and it doesn't touch
drives inserted into other slots.  The less nice thing is that it only
works with SES expanders that provide slot information.  I don't like
Sage's second suggestion because it basically takes over the entire
server.  If newly inserted blank drives are instantly gobbled up by
Ceph, then they can't be used by anything else.  IMHO that kind of
greedy functionality shouldn't be builtin to something as general as
Ceph (though perhaps it could go in a separately installed daemon).

-Alan
