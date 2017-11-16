From: Venky Shankar <vshankar@redhat.com>
Subject: Re: Unittest_rbd_miiror: Build failed in Jenkins: ceph-master #1448
Date: Thu, 16 Nov 2017 04:33:41 -0500
Message-ID: <20171116093341.o7msuimn4vo3cfhd@fedora-vs>
References: <1672609555.4.1510819269612.JavaMail.jenkins@cephdev.digiware.nl>
 <3eda6263-6c8a-0292-9aaa-863f6075cb77@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-it0-f52.google.com ([209.85.214.52]:43402 "EHLO
        mail-it0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933981AbdKPJe2 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 16 Nov 2017 04:34:28 -0500
Received: by mail-it0-f52.google.com with SMTP id m191so5127269itg.2
        for <ceph-devel@vger.kernel.org>; Thu, 16 Nov 2017 01:34:28 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <3eda6263-6c8a-0292-9aaa-863f6075cb77@digiware.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Willem Jan Withagen <wjw@digiware.nl>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On 17-11-16 09:56:36, Willem Jan Withagen wrote:
> Hi
> 
> Unittest_rbd_mirror consistently (twice already) fails in the same test and
> the same traceback.
> 
> Any suggestions as to where to start looking?

Kefu has a PR for this: https://github.com/ceph/ceph/pull/18964

> 
> --WjW
> 
> 
> -------- Forwarded Message --------
> Subject: Build failed in Jenkins: ceph-master #1448
> Date: Thu, 16 Nov 2017 09:01:09 +0100 (CET)
> From: jenkins@digiware.nl
> Reply-To: jenkins@digiware.nl
> To: wjw@digiware.nl
> 
> See <http://cephdev.digiware.nl:8180/jenkins/job/ceph-master/1448/display/redirect?page=changes>
> 
> Changes:
> 
> [enming.zhang] rgw: add rewrite related cmd and parameter into radosgw-admin
> help info
> 
> ------------------------------------------
> [...truncated 3.74 MB...]
> [       OK ] TestMockImageReplayerEventPreprocessor.PreprocessRefreshError
> (71 ms)
> [ RUN      ]
> TestMockImageReplayerEventPreprocessor.PreprocessClientUpdateError
> [       OK ]
> TestMockImageReplayerEventPreprocessor.PreprocessClientUpdateError (73 ms)
> [----------] 9 tests from TestMockImageReplayerEventPreprocessor (622 ms
> total)
> 
> [----------] 11 tests from TestMockImageReplayerCreateImageRequest
> [ RUN      ] TestMockImageReplayerCreateImageRequest.Create
> [       OK ] TestMockImageReplayerCreateImageRequest.Create (70 ms)
> [ RUN      ] TestMockImageReplayerCreateImageRequest.CreateError
> [       OK ] TestMockImageReplayerCreateImageRequest.CreateError (72 ms)
> [ RUN      ] TestMockImageReplayerCreateImageRequest.Clone
> [       OK ] TestMockImageReplayerCreateImageRequest.Clone (676 ms)
> [ RUN      ]
> TestMockImageReplayerCreateImageRequest.CloneGetGlobalImageIdError
> [       OK ]
> TestMockImageReplayerCreateImageRequest.CloneGetGlobalImageIdError (598 ms)
> [ RUN      ]
> TestMockImageReplayerCreateImageRequest.CloneGetLocalParentImageIdError
> [       OK ]
> TestMockImageReplayerCreateImageRequest.CloneGetLocalParentImageIdError (617
> ms)
> [ RUN      ]
> TestMockImageReplayerCreateImageRequest.CloneOpenRemoteParentError
> [       OK ]
> TestMockImageReplayerCreateImageRequest.CloneOpenRemoteParentError (620 ms)
> [ RUN      ]
> TestMockImageReplayerCreateImageRequest.CloneOpenLocalParentError
> [       OK ]
> TestMockImageReplayerCreateImageRequest.CloneOpenLocalParentError (687 ms)
> [ RUN      ] TestMockImageReplayerCreateImageRequest.CloneSnapSetError
> [       OK ] TestMockImageReplayerCreateImageRequest.CloneSnapSetError (709
> ms)
> [ RUN      ] TestMockImageReplayerCreateImageRequest.CloneError
> [       OK ] TestMockImageReplayerCreateImageRequest.CloneError (700 ms)
> [ RUN      ]
> TestMockImageReplayerCreateImageRequest.CloneLocalParentCloseError
> [       OK ]
> TestMockImageReplayerCreateImageRequest.CloneLocalParentCloseError (689 ms)
> [ RUN      ]
> TestMockImageReplayerCreateImageRequest.CloneRemoteParentCloseError
> [       OK ]
> TestMockImageReplayerCreateImageRequest.CloneRemoteParentCloseError (683 ms)
> [----------] 11 tests from TestMockImageReplayerCreateImageRequest (6122 ms
> total)
> 
> [----------] 8 tests from TestMockImageReplayerBootstrapRequest
> [ RUN      ]
> TestMockImageReplayerBootstrapRequest.NonPrimaryRemoteSyncingState
> [       OK ]
> TestMockImageReplayerBootstrapRequest.NonPrimaryRemoteSyncingState (135 ms)
> [ RUN      ] TestMockImageReplayerBootstrapRequest.RemoteDemotePromote
> [       OK ] TestMockImageReplayerBootstrapRequest.RemoteDemotePromote (144
> ms)
> [ RUN      ]
> TestMockImageReplayerBootstrapRequest.MultipleRemoteDemotePromotes
> [       OK ]
> TestMockImageReplayerBootstrapRequest.MultipleRemoteDemotePromotes (142 ms)
> [ RUN      ] TestMockImageReplayerBootstrapRequest.LocalDemoteRemotePromote
> [       OK ] TestMockImageReplayerBootstrapRequest.LocalDemoteRemotePromote
> (137 ms)
> [ RUN      ] TestMockImageReplayerBootstrapRequest.SplitBrainForcePromote
> [       OK ] TestMockImageReplayerBootstrapRequest.SplitBrainForcePromote
> (128 ms)
> [ RUN      ] TestMockImageReplayerBootstrapRequest.ResyncRequested
> [       OK ] TestMockImageReplayerBootstrapRequest.ResyncRequested (132 ms)
> [ RUN      ] TestMockImageReplayerBootstrapRequest.PrimaryRemote
> [       OK ] TestMockImageReplayerBootstrapRequest.PrimaryRemote (134 ms)
> [ RUN      ] TestMockImageReplayerBootstrapRequest.PrimaryRemoteLocalDeleted
> [       OK ] TestMockImageReplayerBootstrapRequest.PrimaryRemoteLocalDeleted
> (137 ms)
> [----------] 8 tests from TestMockImageReplayerBootstrapRequest (1089 ms
> total)
> 
> [----------] 18 tests from TestMockPoolWatcher
> [ RUN      ] TestMockPoolWatcher.EmptyPool
> [       OK ] TestMockPoolWatcher.EmptyPool (3 ms)
> [ RUN      ] TestMockPoolWatcher.NonEmptyPool
> [       OK ] TestMockPoolWatcher.NonEmptyPool (3 ms)
> [ RUN      ] TestMockPoolWatcher.NotifyDuringRefresh
> [       OK ] TestMockPoolWatcher.NotifyDuringRefresh (4 ms)
> [ RUN      ] TestMockPoolWatcher.Notify
> [       OK ] TestMockPoolWatcher.Notify (3 ms)
> [ RUN      ] TestMockPoolWatcher.RegisterWatcherBlacklist
> [       OK ] TestMockPoolWatcher.RegisterWatcherBlacklist (2 ms)
> [ RUN      ] TestMockPoolWatcher.RegisterWatcherMissing
> [       OK ] TestMockPoolWatcher.RegisterWatcherMissing (4 ms)
> [ RUN      ] TestMockPoolWatcher.RegisterWatcherError
> [       OK ] TestMockPoolWatcher.RegisterWatcherError (3 ms)
> [ RUN      ] TestMockPoolWatcher.RefreshBlacklist
> [       OK ] TestMockPoolWatcher.RefreshBlacklist (3 ms)
> [ RUN      ] TestMockPoolWatcher.RefreshMissing
> [       OK ] TestMockPoolWatcher.RefreshMissing (2 ms)
> [ RUN      ] TestMockPoolWatcher.RefreshError
> [       OK ] TestMockPoolWatcher.RefreshError (3 ms)
> [ RUN      ] TestMockPoolWatcher.GetMirrorUuidBlacklist
> [       OK ] TestMockPoolWatcher.GetMirrorUuidBlacklist (2 ms)
> [ RUN      ] TestMockPoolWatcher.GetMirrorUuidMissing
> [       OK ] TestMockPoolWatcher.GetMirrorUuidMissing (3 ms)
> [ RUN      ] TestMockPoolWatcher.GetMirrorUuidError
> [       OK ] TestMockPoolWatcher.GetMirrorUuidError (3 ms)
> [ RUN      ] TestMockPoolWatcher.Rewatch
> [       OK ] TestMockPoolWatcher.Rewatch (3 ms)
> [ RUN      ] TestMockPoolWatcher.RewatchBlacklist
> [       OK ] TestMockPoolWatcher.RewatchBlacklist (2 ms)
> [ RUN      ] TestMockPoolWatcher.RewatchError
> [       OK ] TestMockPoolWatcher.RewatchError (3 ms)
> [ RUN      ] TestMockPoolWatcher.DeferredRefresh
> [       OK ] TestMockPoolWatcher.DeferredRefresh (4 ms)
> [ RUN      ] TestMockPoolWatcher.MirrorUuidUpdated
> [       OK ] TestMockPoolWatcher.MirrorUuidUpdated (3 ms)
> [----------] 18 tests from TestMockPoolWatcher (57 ms total)
> 
> [----------] 5 tests from TestMockLeaderWatcher
> [ RUN      ] TestMockLeaderWatcher.InitShutdown
> [       OK ] TestMockLeaderWatcher.InitShutdown (6 ms)
> [ RUN      ] TestMockLeaderWatcher.InitReleaseShutdown
> [       OK ] TestMockLeaderWatcher.InitReleaseShutdown (6 ms)
> [ RUN      ] TestMockLeaderWatcher.AcquireError
> [       OK ] TestMockLeaderWatcher.AcquireError (7 ms)
> [ RUN      ] TestMockLeaderWatcher.ReleaseError
> [       OK ] TestMockLeaderWatcher.ReleaseError (7 ms)
> [ RUN      ] TestMockLeaderWatcher.Break
> [       OK ] TestMockLeaderWatcher.Break (2101 ms)
> [----------] 5 tests from TestMockLeaderWatcher (2127 ms total)
> 
> [----------] 9 tests from TestMockInstanceWatcher
> [ RUN      ] TestMockInstanceWatcher.InitShutdown
> [       OK ] TestMockInstanceWatcher.InitShutdown (3 ms)
> [ RUN      ] TestMockInstanceWatcher.InitError
> [       OK ] TestMockInstanceWatcher.InitError (3 ms)
> [ RUN      ] TestMockInstanceWatcher.ShutdownError
> [       OK ] TestMockInstanceWatcher.ShutdownError (4 ms)
> [ RUN      ] TestMockInstanceWatcher.Remove
> [       OK ] TestMockInstanceWatcher.Remove (2 ms)
> [ RUN      ] TestMockInstanceWatcher.RemoveNoent
> [       OK ] TestMockInstanceWatcher.RemoveNoent (3 ms)
> [ RUN      ] TestMockInstanceWatcher.ImageAcquireRelease
> [       OK ] TestMockInstanceWatcher.ImageAcquireRelease (63 ms)
> [ RUN      ] TestMockInstanceWatcher.PeerImageRemoved
> [       OK ] TestMockInstanceWatcher.PeerImageRemoved (61 ms)
> [ RUN      ] TestMockInstanceWatcher.ImageAcquireReleaseCancel
> [       OK ] TestMockInstanceWatcher.ImageAcquireReleaseCancel (5 ms)
> [ RUN      ] TestMockInstanceWatcher.PeerImageRemovedCancel
> [       OK ] TestMockInstanceWatcher.PeerImageRemovedCancel (3 ms)
> [----------] 9 tests from TestMockInstanceWatcher (148 ms total)
> 
> [----------] 11 tests from TestMockInstanceWatcher_NotifySync
> [ RUN      ] TestMockInstanceWatcher_NotifySync.StartStopOnLeader
> [       OK ] TestMockInstanceWatcher_NotifySync.StartStopOnLeader (57 ms)
> [ RUN      ] TestMockInstanceWatcher_NotifySync.CancelStartedOnLeader
> [       OK ] TestMockInstanceWatcher_NotifySync.CancelStartedOnLeader (65
> ms)
> [ RUN      ] TestMockInstanceWatcher_NotifySync.StartStopOnNonLeader
> [       OK ] TestMockInstanceWatcher_NotifySync.StartStopOnNonLeader (65 ms)
> [ RUN      ] TestMockInstanceWatcher_NotifySync.CancelStartedOnNonLeader
> [       OK ] TestMockInstanceWatcher_NotifySync.CancelStartedOnNonLeader (68
> ms)
> [ RUN      ] TestMockInstanceWatcher_NotifySync.CancelWaitingOnNonLeader
> [       OK ] TestMockInstanceWatcher_NotifySync.CancelWaitingOnNonLeader (75
> ms)
> [ RUN      ] TestMockInstanceWatcher_NotifySync.InFlightPrevNotification
> [       OK ] TestMockInstanceWatcher_NotifySync.InFlightPrevNotification (64
> ms)
> [ RUN      ]
> TestMockInstanceWatcher_NotifySync.NoInFlightReleaseAcquireLeader
> [       OK ]
> TestMockInstanceWatcher_NotifySync.NoInFlightReleaseAcquireLeader (64 ms)
> [ RUN      ] TestMockInstanceWatcher_NotifySync.StartedOnLeaderReleaseLeader
> [       OK ] TestMockInstanceWatcher_NotifySync.StartedOnLeaderReleaseLeader
> (68 ms)
> [ RUN      ] TestMockInstanceWatcher_NotifySync.WaitingOnLeaderReleaseLeader
> [       OK ] TestMockInstanceWatcher_NotifySync.WaitingOnLeaderReleaseLeader
> (63 ms)
> [ RUN      ]
> TestMockInstanceWatcher_NotifySync.StartedOnNonLeaderAcquireLeader
> [       OK ]
> TestMockInstanceWatcher_NotifySync.StartedOnNonLeaderAcquireLeader (62 ms)
> [ RUN      ]
> TestMockInstanceWatcher_NotifySync.WaitingOnNonLeaderAcquireLeader
> [       OK ]
> TestMockInstanceWatcher_NotifySync.WaitingOnNonLeaderAcquireLeader (64 ms)
> [----------] 11 tests from TestMockInstanceWatcher_NotifySync (716 ms total)
> 
> [----------] 2 tests from TestMockInstanceReplayer
> [ RUN      ] TestMockInstanceReplayer.AcquireReleaseImage
> [       OK ] TestMockInstanceReplayer.AcquireReleaseImage (4 ms)
> [ RUN      ] TestMockInstanceReplayer.RemoveFinishedImage
> [       OK ] TestMockInstanceReplayer.RemoveFinishedImage (2 ms)
> [----------] 2 tests from TestMockInstanceReplayer (6 ms total)
> 
> [----------] 7 tests from TestMockImageSyncThrottler
> [ RUN      ] TestMockImageSyncThrottler.Single_Sync
> [       OK ] TestMockImageSyncThrottler.Single_Sync (1 ms)
> [ RUN      ] TestMockImageSyncThrottler.Multiple_Syncs
> [       OK ] TestMockImageSyncThrottler.Multiple_Syncs (1 ms)
> [ RUN      ] TestMockImageSyncThrottler.Cancel_Running_Sync
> [       OK ] TestMockImageSyncThrottler.Cancel_Running_Sync (2 ms)
> [ RUN      ] TestMockImageSyncThrottler.Cancel_Waiting_Sync
> [       OK ] TestMockImageSyncThrottler.Cancel_Waiting_Sync (1 ms)
> [ RUN      ] TestMockImageSyncThrottler.Cancel_Running_Sync_Start_Waiting
> [       OK ] TestMockImageSyncThrottler.Cancel_Running_Sync_Start_Waiting (2
> ms)
> [ RUN      ] TestMockImageSyncThrottler.Increase_Max_Concurrent_Syncs
> [       OK ] TestMockImageSyncThrottler.Increase_Max_Concurrent_Syncs (1 ms)
> [ RUN      ] TestMockImageSyncThrottler.Decrease_Max_Concurrent_Syncs
> [       OK ] TestMockImageSyncThrottler.Decrease_Max_Concurrent_Syncs (1 ms)
> [----------] 7 tests from TestMockImageSyncThrottler (9 ms total)
> 
> [----------] 5 tests from TestMockImageSync
> [ RUN      ] TestMockImageSync.SimpleSync
> [       OK ] TestMockImageSync.SimpleSync (134 ms)
> [ RUN      ] TestMockImageSync.RestartSync
> [       OK ] TestMockImageSync.RestartSync (134 ms)
> [ RUN      ] TestMockImageSync.CancelNotifySyncRequest
> [       OK ] TestMockImageSync.CancelNotifySyncRequest (139 ms)
> [ RUN      ] TestMockImageSync.CancelImageCopy
> [       OK ] TestMockImageSync.CancelImageCopy (141 ms)
> [ RUN      ] TestMockImageSync.CancelAfterCopyImage
> [       OK ] TestMockImageSync.CancelAfterCopyImage (135 ms)
> [----------] 5 tests from TestMockImageSync (685 ms total)
> 
> [----------] 13 tests from TestMockImageReplayer
> [ RUN      ] TestMockImageReplayer.StartStop
> [       OK ] TestMockImageReplayer.StartStop (146 ms)
> [ RUN      ] TestMockImageReplayer.LocalImagePrimary
> [       OK ] TestMockImageReplayer.LocalImagePrimary (141 ms)
> [ RUN      ] TestMockImageReplayer.LocalImageDNE
> [       OK ] TestMockImageReplayer.LocalImageDNE (141 ms)
> [ RUN      ] TestMockImageReplayer.PrepareLocalImageError
> [       OK ] TestMockImageReplayer.PrepareLocalImageError (145 ms)
> [ RUN      ] TestMockImageReplayer.GetRemoteImageIdDNE
> [       OK ] TestMockImageReplayer.GetRemoteImageIdDNE (134 ms)
> [ RUN      ] TestMockImageReplayer.GetRemoteImageIdNonLinkedDNE
> [       OK ] TestMockImageReplayer.GetRemoteImageIdNonLinkedDNE (135 ms)
> [ RUN      ] TestMockImageReplayer.GetRemoteImageIdError
> [       OK ] TestMockImageReplayer.GetRemoteImageIdError (130 ms)
> [ RUN      ] TestMockImageReplayer.BootstrapError
> [       OK ] TestMockImageReplayer.BootstrapError (132 ms)
> [ RUN      ] TestMockImageReplayer.StartExternalReplayError
> [       OK ] TestMockImageReplayer.StartExternalReplayError (150 ms)
> [ RUN      ] TestMockImageReplayer.StopError
> [       OK ] TestMockImageReplayer.StopError (142 ms)
> [ RUN      ] TestMockImageReplayer.Replay
> [       OK ] TestMockImageReplayer.Replay (135 ms)
> [ RUN      ] TestMockImageReplayer.DecodeError
> [       OK ] TestMockImageReplayer.DecodeError (138 ms)
> [ RUN      ] TestMockImageReplayer.DelayedReplay
> [       OK ] TestMockImageReplayer.DelayedReplay (2273 ms)
> [----------] 13 tests from TestMockImageReplayer (3944 ms total)
> 
> [----------] 12 tests from TestMockImageMap
> [ RUN      ] TestMockImageMap.SetLocalImages
> /home/jenkins/workspace/ceph-master/src/tools/rbd_mirror/image_map/StateTransition.cc:
> In function 'static const StateTransition::Transition &rbd::mirror::image_map::StateTransition::transit(rbd::mirror::image_map::StateTransition::ActionType,
> rbd::mirror::image_map::StateTransition::State)' thread 8100d6d00 time
> 2017-11-16 09:01:08.164274
> /home/jenkins/workspace/ceph-master/src/tools/rbd_mirror/image_map/StateTransition.cc:
> 78: FAILED assert(false)
>  ceph version Development (no_version) mimic (dev)
>  1: <ceph::__ceph_assert_fail(char const*, char const, int, char
> const)+0xb06> at
> /home/jenkins/workspace/ceph-master/build/lib/libceph-common.so.0
>  2: <rbd::mirror::image_map::StateTransition::transit(rbd::mirror::image_map::StateTransition::ActionType,
> rbd::mirror::image_map::StateTransition::State)+0xa3> at
> /home/jenkins/workspace/ceph-master/build/bin/unittest_rbd_mirror
>  3: <rbd::mirror::image_map::Policy::start_next_action(std::__1::basic_string<char,
> rbd::mirror::image_map::Policy::start_next_action::char_traits<char>,
> rbd::mirror::image_map::Policy::start_next_action::allocator<char> >
> const&)+0x4a4> at
> /home/jenkins/workspace/ceph-master/build/bin/unittest_rbd_mirror
>  4: <rbd::mirror::ImageMap<librbd::(anonymous
> namespace)::MockTestImageCtx>::process_updates(void)+0x5b5> at
> /home/jenkins/workspace/ceph-master/build/bin/unittest_rbd_mirror
>  5: <_ZZN3rbd6mirror8ImageMapIN6librbd12_GLOBAL__N_116MockTestImageCtxEE20schedule_update_taskEvENKUliE_clEi()+0x6f>
> at /home/jenkins/workspace/ceph-master/build/bin/unittest_rbd_mirror
>  6: <_ZN5boost6detail8function26void_function_obj_invoker1IZN3rbd6mirror8ImageMapIN6librbd12_GLOBAL__N_116MockTestImageCtxEE20schedule_update_taskEvEUliE_viE6invokeERNS1_15function_bufferEi()+0x36>
> at /home/jenkins/workspace/ceph-master/build/bin/unittest_rbd_mirror
>  7: <boost::function1<void, int>::operator()(int) const+0x96> at
> /home/jenkins/workspace/ceph-master/build/bin/unittest_rbd_mirror
>  8: <FunctionContext::finish(int)+0x1f> at
> /home/jenkins/workspace/ceph-master/build/bin/unittest_rbd_mirror
>  9: <Context::complete(int)+0x22> at
> /home/jenkins/workspace/ceph-master/build/bin/unittest_rbd_mirror
>  10: <_ZZZN3rbd6mirror16TestMockImageMap16expect_add_eventERNS0_7ThreadsIN6librbd12_GLOBAL__N_116MockTestImageCtxEEEENKUlP7ContextE_clES9_ENKUliE_clEi()+0x52>
> at /home/jenkins/workspace/ceph-master/build/bin/unittest_rbd_mirror
>  11: <_ZN5boost6detail8function26void_function_obj_invoker1IZZN3rbd6mirror16TestMockImageMap16expect_add_eventERNS4_7ThreadsIN6librbd12_GLOBAL__N_116MockTestImageCtxEEEENKUlP7ContextE_clESD_EUliE_viE6invokeERNS1_15function_bufferEi()+0x36>
> at /home/jenkins/workspace/ceph-master/build/bin/unittest_rbd_mirror
>  12: <boost::function1<void, int>::operator()(int) const+0x96> at
> /home/jenkins/workspace/ceph-master/build/bin/unittest_rbd_mirror
>  13: <FunctionContext::finish(int)+0x1f> at
> /home/jenkins/workspace/ceph-master/build/bin/unittest_rbd_mirror
>  14: <Context::complete(int)+0x22> at
> /home/jenkins/workspace/ceph-master/build/bin/unittest_rbd_mirror
>  15: <ContextWQ::process(Context*)+0x371> at
> /home/jenkins/workspace/ceph-master/build/bin/unittest_rbd_mirror
>  16: <ThreadPool::PointerWQ<Context>::_void_process(void*,
> ThreadPool::TPHandle&)+0x3b> at
> /home/jenkins/workspace/ceph-master/build/bin/unittest_rbd_mirror
>  17: <ThreadPool::worker(ThreadPool::WorkThread*)+0x13dc> at
> /home/jenkins/workspace/ceph-master/build/lib/libceph-common.so.0
>  18: <ThreadPool::WorkThread::entry(void)+0x24> at
> /home/jenkins/workspace/ceph-master/build/lib/libceph-common.so.0
>  19: <Thread::entry_wrapper(void)+0xc6> at
> /home/jenkins/workspace/ceph-master/build/lib/libceph-common.so.0
>  20: <Thread::_entry_func(void*)+0x15> at
> /home/jenkins/workspace/ceph-master/build/lib/libceph-common.so.0
>  NOTE: a copy of the executable, or `objdump -rdS <executable>` is needed to
> interpret this.
> 
> 
> 0% tests passed, 1 tests failed out of 1
> 
> Total Test time (real) = 142.05 sec
> 
> The following tests FAILED:
> 	145 - unittest_rbd_mirror (OTHER_FAULT)
> Errors while running CTest
> Build step 'Execute shell' marked build as failure
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
