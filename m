From: Jason Dillaman <jdillama@redhat.com>
Subject: Re: [ceph-users] rbd rm snap on image with exclusive lock
Date: Wed, 25 Oct 2017 08:39:07 -0400
Message-ID: <CA+aFP1BA-PvFSeJTYbJYmz1guee+N7CvM0E8p_h0pbP=4dO+4g@mail.gmail.com>
References: <6a5fdefb-cd9e-8a29-b668-945312e9827f@corp.ovh.com>
Reply-To: dillaman@redhat.com
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f171.google.com ([209.85.161.171]:53378 "EHLO
        mail-yw0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750949AbdJYMjI (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 25 Oct 2017 08:39:08 -0400
Received: by mail-yw0-f171.google.com with SMTP id q126so14907671ywq.10
        for <ceph-devel@vger.kernel.org>; Wed, 25 Oct 2017 05:39:08 -0700 (PDT)
In-Reply-To: <6a5fdefb-cd9e-8a29-b668-945312e9827f@corp.ovh.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?UTF-8?B?UGlvdHIgRGHFgmVr?= <piotr.dalek@corp.ovh.com>
Cc: ceph-users <ceph-users@lists.ceph.com>, ceph-devel <ceph-devel@vger.kernel.org>

That log is showing that a snap remove request was made from a client
that couldn't acquire the lock to a client that currently owns the
lock. The client that currently owns the lock responded w/ an -ENOENT
error that the snapshot doesn't exist. Depending on the maintenance
operation requested, different errors codes are filtered out to handle
the case where Ceph double (or more) delivers the request message to
the lock owner. Normally this isn't an issue since the local client
pre-checks the image state before sending the RPC message (i.e. snap
remove will first locally ensure the snap exists and respond w/
-ENOENT if it doesn't).

Therefore, in this case, the question is who is this rogue client that
still owns the lock and is responding the a snap remove request but
hasn't refreshed its state to know that the snapshot exists.

On Wed, Oct 25, 2017 at 3:33 AM, Piotr Dałek <piotr.dalek@corp.ovh.com> wrote:
> Hello,
>
> I have a 10.2.5 Ceph cluster, there is an image with exclusive lock that is
> being held by client. Some other client creates a snapshot on that image,
> then (that client) goes away. Later, third client attempts to remove that
> snapshot using rbd snap rm, but fails to do so without error:
>
> 2017-10-24 09:50:29.585675 7f754cbb1d80  5 librbd::AioImageRequestWQ:
> 0x7f75579349f0 : ictx=0x7f7557932f50
> 2017-10-24 09:50:29.585759 7f754cbb1d80 20 librbd::ImageState: open
> 2017-10-24 09:50:29.585761 7f754cbb1d80 10 librbd::ImageState:
> 0x7f7557933d90 send_open_unlock
> 2017-10-24 09:50:29.585767 7f754cbb1d80 10 librbd::image::OpenRequest:
> 0x7f7557935360 send_v2_detect_header
> 2017-10-24 09:50:29.588006 7f752e205700 10 librbd::image::OpenRequest:
> handle_v2_detect_header: r=0
> 2017-10-24 09:50:29.588018 7f752e205700 10 librbd::image::OpenRequest:
> 0x7f7557935360 send_v2_get_id
> 2017-10-24 09:50:29.589679 7f752e205700 10 librbd::image::OpenRequest:
> handle_v2_get_id: r=0
> 2017-10-24 09:50:29.589698 7f752e205700 10 librbd::image::OpenRequest:
> 0x7f7557935360 send_v2_get_immutable_metadata
> 2017-10-24 09:50:29.598466 7f752e205700 10 librbd::image::OpenRequest:
> handle_v2_get_immutable_metadata: r=0
> 2017-10-24 09:50:29.598481 7f752e205700 10 librbd::image::OpenRequest:
> 0x7f7557935360 send_v2_get_stripe_unit_count
> 2017-10-24 09:50:29.601050 7f752e205700 10 librbd::image::OpenRequest:
> handle_v2_get_stripe_unit_count: r=-8
> 2017-10-24 09:50:29.601074 7f752e205700 10 librbd::ImageCtx: init_layout
> stripe_unit 4194304 stripe_count 1 object_size 4194304 prefix
> rbd_data.[redacted] format rbd_data.[redacted].%016llx
> 2017-10-24 09:50:29.601077 7f752e205700 10 librbd::image::OpenRequest:
> 0x7f7557935360 send_v2_apply_metadata: start_key=conf_
> 2017-10-24 09:50:29.603277 7f752e205700 10 librbd::image::OpenRequest:
> 0x7f7557935360 handle_v2_apply_metadata: r=0
> 2017-10-24 09:50:29.603294 7f752e205700 20 librbd::ImageCtx: apply_metadata
> 2017-10-24 09:50:29.603425 7f752e205700 20 librbd::ImageCtx: enabling
> caching...
> 2017-10-24 09:50:29.603432 7f752e205700 20 librbd::ImageCtx: Initial cache
> settings: size=33554432 num_objects=10 max_dirty=25165824
> target_dirty=16777216 max_dirty_age=1
> 2017-10-24 09:50:29.603535 7f752e205700 10 librbd::ImageCtx:  cache bytes
> 33554432 -> about 1048 objects
> 2017-10-24 09:50:29.603790 7f752e205700 10 librbd::image::OpenRequest:
> 0x7f7557935360 send_register_watch
> 2017-10-24 09:50:29.603867 7f752e205700 10 librbd::ImageWatcher:
> 0x7f75140017e0 registering image watcher
> 2017-10-24 09:50:29.606497 7f752e205700 10 librbd::image::OpenRequest:
> 0x7f7557935360 handle_register_watch: r=0
> 2017-10-24 09:50:29.606513 7f752e205700 10 librbd::image::OpenRequest:
> 0x7f7557935360 send_refresh
> 2017-10-24 09:50:29.606518 7f752e205700 10 librbd::image::RefreshRequest:
> 0x7f7514008ab0 send_v2_get_mutable_metadata
> 2017-10-24 09:50:29.619931 7f752e205700 10 librbd::image::RefreshRequest:
> 0x7f7514008ab0 handle_v2_get_mutable_metadata: r=0
> 2017-10-24 09:50:29.619964 7f752e205700 10 librbd::image::RefreshRequest:
> 0x7f7514008ab0 send_v2_get_flags
> 2017-10-24 09:50:29.626218 7f752e205700 10 librbd::image::RefreshRequest:
> 0x7f7514008ab0 handle_v2_get_flags: r=0
> 2017-10-24 09:50:29.626239 7f752e205700 10 librbd::image::RefreshRequest:
> 0x7f7514008ab0 send_v2_get_snapshots
> 2017-10-24 09:50:29.647141 7f752e205700 10 librbd::image::RefreshRequest:
> 0x7f7514008ab0 handle_v2_get_snapshots: r=0
> 2017-10-24 09:50:29.647164 7f752e205700 10 librbd::image::RefreshRequest:
> 0x7f7514008ab0 send_v2_init_exclusive_lock
> 2017-10-24 09:50:29.647173 7f752e205700 10 librbd::ExclusiveLock:
> 0x7f7514013510 init
> 2017-10-24 09:50:29.647177 7f752e205700  5 librbd::AioImageRequestWQ:
> block_writes: 0x7f7557932f50, num=1
> 2017-10-24 09:50:29.647227 7f752da04700 10 librbd::ExclusiveLock:
> 0x7f7514013510 handle_init_complete
> 2017-10-24 09:50:29.647237 7f752da04700 10 librbd::image::RefreshRequest:
> 0x7f7514008ab0 handle_v2_init_exclusive_lock: r=0
> 2017-10-24 09:50:29.647239 7f752da04700 10 librbd::image::RefreshRequest:
> 0x7f7514008ab0 send_v2_apply
> 2017-10-24 09:50:29.647242 7f752da04700 10 librbd::image::RefreshRequest:
> 0x7f7514008ab0 handle_v2_apply
> 2017-10-24 09:50:29.647246 7f752da04700 20 librbd::image::RefreshRequest:
> 0x7f7514008ab0 apply
> 2017-10-24 09:50:29.647248 7f752da04700 20 librbd::image::RefreshRequest:
> new snapshot id=272717 name=[redacted name] size=107374182400
> 2017-10-24 09:50:29.647257 7f752da04700 20 librbd::image::RefreshRequest:
> new snapshot id=240459 name=[redacted name#2] size=107374182400
> 2017-10-24 09:50:29.647270 7f752da04700 10 librbd::image::RefreshRequest:
> 0x7f7514008ab0 send_flush_aio
> 2017-10-24 09:50:29.647272 7f752da04700 10 librbd::image::RefreshRequest:
> 0x7f7514008ab0 handle_flush_aio: r=0
> 2017-10-24 09:50:29.647276 7f752da04700 10 librbd::image::OpenRequest:
> handle_refresh: r=0
> 2017-10-24 09:50:29.647278 7f752da04700 10 librbd::ImageState:
> 0x7f7557933d90 handle_open: r=0
> 2017-10-24 09:50:29.647328 7f754cbb1d80  5 librbd::Operations:
> 0x7f7557933a90 snap_remove: snap_name=[redacted name]
> 2017-10-24 09:50:29.647345 7f754cbb1d80 20 librbd::ExclusiveLock:
> 0x7f7514013510 is_lock_owner=0
> 2017-10-24 09:50:29.647346 7f754cbb1d80 20 librbd::Operations:
> send_acquire_exclusive_lock
> 2017-10-24 09:50:29.647347 7f754cbb1d80 10 librbd::ExclusiveLock:
> 0x7f7514013510 try_lock
> 2017-10-24 09:50:29.647349 7f754cbb1d80 10 librbd::ExclusiveLock:
> 0x7f7514013510 send_acquire_lock
> 2017-10-24 09:50:29.647355 7f754cbb1d80 10
> librbd::exclusive_lock::AcquireRequest: send_flush_notifies
> 2017-10-24 09:50:29.647377 7f752da04700 10
> librbd::exclusive_lock::AcquireRequest: handle_flush_notifies
> 2017-10-24 09:50:29.647378 7f752da04700 10
> librbd::exclusive_lock::AcquireRequest: send_lock
> 2017-10-24 09:50:29.648043 7f752e205700 10
> librbd::exclusive_lock::AcquireRequest: handle_lock: r=-16
> 2017-10-24 09:50:29.648052 7f752e205700 10
> librbd::exclusive_lock::AcquireRequest: send_get_lockers
> 2017-10-24 09:50:29.648829 7f752e205700 10
> librbd::exclusive_lock::AcquireRequest: handle_get_lockers: r=0
> 2017-10-24 09:50:29.648870 7f752e205700 10
> librbd::exclusive_lock::AcquireRequest: retrieved exclusive locker:
> client.194595200@[redacted]:0/xxx
> 2017-10-24 09:50:29.648875 7f752e205700 10
> librbd::exclusive_lock::AcquireRequest: send_get_watchers
> 2017-10-24 09:50:29.649385 7f752e205700 10
> librbd::exclusive_lock::AcquireRequest: handle_get_watchers: r=0
> 2017-10-24 09:50:29.649402 7f752e205700 10
> librbd::exclusive_lock::AcquireRequest: lock owner is still alive
> 2017-10-24 09:50:29.649448 7f752da04700 10 librbd::ExclusiveLock:
> 0x7f7514013510 handle_acquire_lock: r=-11
> 2017-10-24 09:50:29.649463 7f752da04700  5 librbd::ExclusiveLock: unable to
> acquire exclusive lock
> 2017-10-24 09:50:29.649466 7f752da04700 20 librbd::Operations:
> handle_acquire_exclusive_lock: r=0
> 2017-10-24 09:50:29.649468 7f752da04700 20 librbd::ExclusiveLock:
> 0x7f7514013510 is_lock_owner=0
> 2017-10-24 09:50:29.649469 7f752da04700 20 librbd::Operations:
> send_remote_request
> 2017-10-24 09:50:29.649474 7f752da04700 20 librbd::ExclusiveLock:
> 0x7f7514013510 is_lock_owner=0
> 2017-10-24 09:50:29.649486 7f752da04700 20
> librbd::image_watcher::NotifyLockOwner: 0x7f7518003f20 send_notify
> 2017-10-24 09:50:29.649489 7f752da04700 20 librbd::image_watcher::Notifier:
> notify: pending=1
> 2017-10-24 09:50:29.650619 7f752e205700 10 librbd::ImageWatcher:
> 0x7f751400d450 C_NotifyAck start: id=2156253971222630,
> handle=140140823478912
> 2017-10-24 09:50:29.650645 7f752e205700 20 librbd::ExclusiveLock:
> 0x7f7514013510 accept_requests=0
> 2017-10-24 09:50:29.650647 7f752e205700 10 librbd::ImageWatcher:
> 0x7f751400d450 C_NotifyAck finish: id=2156253971222630,
> handle=140140823478912
> 2017-10-24 09:50:29.652125 7f752e205700 20 librbd::image_watcher::Notifier:
> handle_notify: pending=0
> 2017-10-24 09:50:29.652147 7f752da04700 20
> librbd::image_watcher::NotifyLockOwner: 0x7f7518003f20 handle_notify: r=0
> 2017-10-24 09:50:29.652154 7f752da04700 20 librbd::Operations:
> handle_remote_request: r=-2
> 2017-10-24 09:50:29.652157 7f752da04700 20 librbd::ImageState:
> handle_update_notification: refresh_seq = 1, last_refresh = 0
> 2017-10-24 09:50:29.652158 7f752da04700 20 librbd::ImageState:
> ImageUpdateWatchers::notify
> 2017-10-24 09:50:29.652203 7f754cbb1d80 20 librbd::ImageState: close
> 2017-10-24 09:50:29.652217 7f754cbb1d80 10 librbd::ImageState:
> 0x7f7557933d90 send_close_unlock
> 2017-10-24 09:50:29.652220 7f754cbb1d80 10 librbd::image::CloseRequest:
> 0x7f7557939090 send_shut_down_update_watchers
> 2017-10-24 09:50:29.652223 7f754cbb1d80 20 librbd::ImageState:
> shut_down_update_watchers
> 2017-10-24 09:50:29.652223 7f754cbb1d80 20 librbd::ImageState:
> ImageUpdateWatchers::shut_down
> 2017-10-24 09:50:29.652224 7f754cbb1d80 20 librbd::ImageState:
> ImageUpdateWatchers::shut_down: completing shut down
> 2017-10-24 09:50:29.652248 7f752da04700 10 librbd::image::CloseRequest:
> 0x7f7557939090 handle_shut_down_update_watchers: r=0
> 2017-10-24 09:50:29.652250 7f752da04700 10 librbd::image::CloseRequest:
> 0x7f7557939090 send_unregister_image_watcher
> 2017-10-24 09:50:29.652252 7f752da04700 10 librbd::ImageWatcher:
> 0x7f75140017e0 unregistering image watcher
> 2017-10-24 09:50:29.654657 7f752da04700 10 librbd::image::CloseRequest:
> 0x7f7557939090 handle_unregister_image_watcher: r=0
> 2017-10-24 09:50:29.654675 7f752da04700 10 librbd::image::CloseRequest:
> 0x7f7557939090 send_shut_down_aio_queue
> 2017-10-24 09:50:29.654677 7f752da04700  5 librbd::AioImageRequestWQ:
> shut_down: in_flight=0
> 2017-10-24 09:50:29.654684 7f752da04700 10 librbd::image::CloseRequest:
> 0x7f7557939090 handle_shut_down_aio_queue: r=0
> 2017-10-24 09:50:29.654686 7f752da04700 10 librbd::image::CloseRequest:
> 0x7f7557939090 send_shut_down_exclusive_lock
> 2017-10-24 09:50:29.654687 7f752da04700 10 librbd::ExclusiveLock:
> 0x7f7514013510 shut_down
> 2017-10-24 09:50:29.654690 7f752da04700 10 librbd::ExclusiveLock:
> 0x7f7514013510 handle_shutdown: r=0
> 2017-10-24 09:50:29.654693 7f752da04700 20 librbd::AioImageRequestWQ:
> clear_require_lock_on_read
> 2017-10-24 09:50:29.654694 7f752da04700  5 librbd::AioImageRequestWQ:
> unblock_writes: 0x7f7557932f50, num=0
> 2017-10-24 09:50:29.654697 7f752da04700 10 librbd::image::CloseRequest:
> 0x7f7557939090 handle_shut_down_exclusive_lock: r=0
> 2017-10-24 09:50:29.654700 7f752da04700 10 librbd::image::CloseRequest:
> 0x7f7557939090 send_flush_readahead
> 2017-10-24 09:50:29.654702 7f752da04700 10 librbd::image::CloseRequest:
> 0x7f7557939090 handle_flush_readahead: r=0
> 2017-10-24 09:50:29.654702 7f752da04700 10 librbd::image::CloseRequest:
> 0x7f7557939090 send_shut_down_cache
> 2017-10-24 09:50:29.654789 7f752da04700 10 librbd::image::CloseRequest:
> 0x7f7557939090 handle_shut_down_cache: r=0
> 2017-10-24 09:50:29.654793 7f752da04700 10 librbd::image::CloseRequest:
> 0x7f7557939090 send_flush_op_work_queue
> 2017-10-24 09:50:29.654796 7f752da04700 10 librbd::image::CloseRequest:
> 0x7f7557939090 handle_flush_op_work_queue: r=0
> 2017-10-24 09:50:29.654799 7f752da04700 10 librbd::image::CloseRequest:
> 0x7f7557939090 handle_flush_image_watcher: r=0
> 2017-10-24 09:50:29.654812 7f752da04700 10 librbd::ImageState:
> 0x7f7557933d90 handle_close: r=0
>
> According to the log above, exclusive lock code set error code to EBUSY,
> which makes sense considering that the client owns the lock and is still
> alive. Then it's translated to EAGAIN, again making sense (client may go
> away at some point and just drop the lock). Then out of sudden, that gets
> translated to ENOENT that gets swallowed by filter in
> C_InvokeAsyncRequest::finish(). These two things don't make any sense at
> all.
>
> So, two questions:
> 1. Why it is possible to create snapshots but not remove them when exclusive
> lock on image is taken? (jewel bug?)
> 2. Why the error is transformed and then ignored?
>
> --
> Piotr Dałek
> piotr.dalek@corp.ovh.com
> https://www.ovh.com/us/
> _______________________________________________
> ceph-users mailing list
> ceph-users@lists.ceph.com
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com



-- 
Jason
