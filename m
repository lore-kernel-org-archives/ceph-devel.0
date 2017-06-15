From: Casey Bodley <cbodley@redhat.com>
Subject: Re: Fwd: Build failed in Jenkins: ceph-master #804
Date: Thu, 15 Jun 2017 10:44:43 -0400
Message-ID: <97ec6826-d5d0-206f-7461-79a786fd304a@redhat.com>
References: <394935589.12.1497535633528.JavaMail.jenkins@cephdev.digiware.nl>
 <f59d7e73-01ed-255c-9dee-85805f36ae56@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qt0-f169.google.com ([209.85.216.169]:34386 "EHLO
        mail-qt0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752602AbdFOOoq (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 15 Jun 2017 10:44:46 -0400
Received: by mail-qt0-f169.google.com with SMTP id c10so23280500qtd.1
        for <ceph-devel@vger.kernel.org>; Thu, 15 Jun 2017 07:44:46 -0700 (PDT)
Received: from [10.17.151.126] ([12.118.3.106])
        by smtp.gmail.com with ESMTPSA id n11sm225314qtb.39.2017.06.15.07.44.44
        for <ceph-devel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Jun 2017 07:44:44 -0700 (PDT)
In-Reply-To: <f59d7e73-01ed-255c-9dee-85805f36ae56@digiware.nl>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

Yeah, this was changed in https://github.com/ceph/ceph/pull/15376. That 
Boost::thread string shouldn't be making it to the link line. Can you 
share your cmake --version?


On 06/15/2017 10:23 AM, Willem Jan Withagen wrote:
> FreeBSD jenkins is faulting...
>
> Summary:
> gmake[2]: Leaving directory '/home/jenkins/workspace/ceph-master/build'
> [ 39%] Built target rbd_mirror_internal
> /usr/bin/ld: cannot find -lBoost::thread
> c++: error: linker command failed with exit code 1 (use -v to see
> invocation)
>
> So I guess that is due to the most recent changes to Boost.
>
> But both on Centos and FreeBSD is find libraries of the names:
> /home/wjw/Ceph/work/ceph/build/boost/lib/libboost_thread.a
> /home/wjw/Ceph/work/ceph/build/boost/lib/libboost_thread.so
> /home/wjw/Ceph/work/ceph/build/boost/lib/libboost_thread.so.1.63.0
>
> --WjW
>
>
>
> -------- Forwarded Message --------
> Subject: Build failed in Jenkins: ceph-master #804
> Date: Thu, 15 Jun 2017 16:07:12 +0200 (CEST)
> From: jenkins@digiware.nl
> Reply-To: jenkins@digiware.nl
> To: wjw@digiware.nl
>
> See
> <http://cephdev.digiware.nl:8180/jenkins/job/ceph-master/804/display/redirect?page=changes>
>
> [ 39%] Linking CXX shared library ../lib/libceph-common.so
> cd /home/jenkins/workspace/ceph-master/build/src && /usr/local/bin/cmake
> -E cmake_link_script CMakeFiles/ceph-common.dir/link.txt --verbose=1
> cd /home/jenkins/workspace/ceph-master/build/src && /usr/local/bin/cmake
> -E cmake_link_script CMakeFiles/common.dir/link.txt --verbose=1
> ccache /usr/bin/CC  -fPIC  -Wall -Wtype-limits -Wignored-qualifiers
> -Winit-self -Wpointer-arith -Werror=format-security -fno-strict-aliasing
> -fsigned-char -Wno-unknown-pragmas -Wno-unused-function
> -Wno-unused-local-typedef -Wno-varargs -Wno-gnu-designator
> -Wno-missing-braces -Wno-parentheses -Wno-deprecated-register
> -ftemplate-depth-1024 -Wno-invalid-offsetof -Wnon-virtual-dtor
> -Wno-unknown-pragmas -Wno-inconsistent-missing-override
> -Wno-mismatched-tags -Wno-unused-private-field -fdiagnostics-color=auto
> -I/usr/local/include/nss/nss -I/usr/local/include/nspr
> -fno-builtin-malloc -fno-builtin-calloc -fno-builtin-realloc
> -fno-builtin-free  -O0 -g  -shared -Wl,-soname,libceph-common.so.0 -o
> ../lib/libceph-common.so.0
> CMakeFiles/common_buffer_obj.dir/common/buffer.cc.o
> CMakeFiles/common_texttable_obj.dir/common/TextTable.cc.o
> compressor/CMakeFiles/compressor_objs.dir/Compressor.cc.o
> compressor/CMakeFiles/compressor_objs.dir/AsyncCompressor.cc.o
> CMakeFiles/common-objs.dir/ceph_ver.c.o
> CMakeFiles/common-objs.dir/common/AsyncOpTracker.cc.o
> CMakeFiles/common-objs.dir/common/DecayCounter.cc.o
> CMakeFiles/common-objs.dir/common/LogClient.cc.o
> CMakeFiles/common-objs.dir/common/LogEntry.cc.o
> CMakeFiles/common-objs.dir/common/PrebufferedStreambuf.cc.o
> CMakeFiles/common-objs.dir/common/BackTrace.cc.o
> CMakeFiles/common-objs.dir/common/perf_counters.cc.o
> CMakeFiles/common-objs.dir/common/perf_histogram.cc.o
> CMakeFiles/common-objs.dir/common/mutex_debug.cc.o
> CMakeFiles/common-objs.dir/common/Mutex.cc.o
> CMakeFiles/common-objs.dir/common/OutputDataSocket.cc.o
> CMakeFiles/common-objs.dir/common/admin_socket.cc.o
> CMakeFiles/common-objs.dir/common/admin_socket_client.cc.o
> CMakeFiles/common-objs.dir/common/bloom_filter.cc.o
> CMakeFiles/common-objs.dir/common/Readahead.cc.o
> CMakeFiles/common-objs.dir/common/cmdparse.cc.o
> CMakeFiles/common-objs.dir/common/escape.c.o
> CMakeFiles/common-objs.dir/common/url_escape.cc.o
> CMakeFiles/common-objs.dir/common/io_priority.cc.o
> CMakeFiles/common-objs.dir/common/Clock.cc.o
> CMakeFiles/common-objs.dir/common/ceph_time.cc.o
> CMakeFiles/common-objs.dir/common/mempool.cc.o
> CMakeFiles/common-objs.dir/common/Throttle.cc.o
> CMakeFiles/common-objs.dir/common/Timer.cc.o
> CMakeFiles/common-objs.dir/common/Finisher.cc.o
> CMakeFiles/common-objs.dir/common/environment.cc.o
> CMakeFiles/common-objs.dir/common/sctp_crc32.c.o
> CMakeFiles/common-objs.dir/common/crc32c.cc.o
> CMakeFiles/common-objs.dir/common/crc32c_intel_baseline.c.o
> CMakeFiles/common-objs.dir/xxHash/xxhash.c.o
> CMakeFiles/common-objs.dir/common/assert.cc.o
> CMakeFiles/common-objs.dir/common/run_cmd.cc.o
> CMakeFiles/common-objs.dir/common/WorkQueue.cc.o
> CMakeFiles/common-objs.dir/common/ConfUtils.cc.o
> CMakeFiles/common-objs.dir/common/MemoryModel.cc.o
> CMakeFiles/common-objs.dir/common/fd.cc.o
> CMakeFiles/common-objs.dir/common/xattr.c.o
> CMakeFiles/common-objs.dir/common/str_list.cc.o
> CMakeFiles/common-objs.dir/common/str_map.cc.o
> CMakeFiles/common-objs.dir/common/snap_types.cc.o
> CMakeFiles/common-objs.dir/common/errno.cc.o
> CMakeFiles/common-objs.dir/common/TrackedOp.cc.o
> CMakeFiles/common-objs.dir/common/SloppyCRCMap.cc.o
> CMakeFiles/common-objs.dir/common/types.cc.o
> CMakeFiles/common-objs.dir/common/iso_8601.cc.o
> CMakeFiles/common-objs.dir/log/Log.cc.o
> CMakeFiles/common-objs.dir/log/SubsystemMap.cc.o
> CMakeFiles/common-objs.dir/mon/MonCap.cc.o
> CMakeFiles/common-objs.dir/mon/MonClient.cc.o
> CMakeFiles/common-objs.dir/mon/MonMap.cc.o
> CMakeFiles/common-objs.dir/mgr/MgrClient.cc.o
> CMakeFiles/common-objs.dir/msg/simple/Accepter.cc.o
> CMakeFiles/common-objs.dir/msg/DispatchQueue.cc.o
> CMakeFiles/common-objs.dir/msg/Message.cc.o
> CMakeFiles/common-objs.dir/mon/PGMap.cc.o
> CMakeFiles/common-objs.dir/osd/ECMsgTypes.cc.o
> CMakeFiles/common-objs.dir/osd/HitSet.cc.o
> CMakeFiles/common-objs.dir/common/RefCountedObj.cc.o
> CMakeFiles/common-objs.dir/msg/Messenger.cc.o
> CMakeFiles/common-objs.dir/msg/simple/Pipe.cc.o
> CMakeFiles/common-objs.dir/msg/simple/PipeConnection.cc.o
> CMakeFiles/common-objs.dir/msg/simple/SimpleMessenger.cc.o
> CMakeFiles/common-objs.dir/msg/async/AsyncConnection.cc.o
> CMakeFiles/common-objs.dir/msg/async/AsyncMessenger.cc.o
> CMakeFiles/common-objs.dir/msg/async/Event.cc.o
> CMakeFiles/common-objs.dir/msg/async/EventSelect.cc.o
> CMakeFiles/common-objs.dir/msg/async/Stack.cc.o
> CMakeFiles/common-objs.dir/msg/async/PosixStack.cc.o
> CMakeFiles/common-objs.dir/msg/async/net_handler.cc.o
> CMakeFiles/common-objs.dir/msg/QueueStrategy.cc.o
> CMakeFiles/common-objs.dir/msg/msg_types.cc.o
> CMakeFiles/common-objs.dir/common/reverse.c.o
> CMakeFiles/common-objs.dir/common/hobject.cc.o
> CMakeFiles/common-objs.dir/osd/OSDMap.cc.o
> CMakeFiles/common-objs.dir/osd/OSDMapMapping.cc.o
> CMakeFiles/common-objs.dir/common/histogram.cc.o
> CMakeFiles/common-objs.dir/osd/osd_types.cc.o
> CMakeFiles/common-objs.dir/osd/OpRequest.cc.o
> CMakeFiles/common-objs.dir/common/blkdev.cc.o
> CMakeFiles/common-objs.dir/common/common_init.cc.o
> CMakeFiles/common-objs.dir/common/pipe.c.o
> CMakeFiles/common-objs.dir/common/ceph_argparse.cc.o
> CMakeFiles/common-objs.dir/common/ceph_context.cc.o
> CMakeFiles/common-objs.dir/common/code_environment.cc.o
> CMakeFiles/common-objs.dir/common/dout.cc.o
> CMakeFiles/common-objs.dir/common/signal.cc.o
> CMakeFiles/common-objs.dir/common/Thread.cc.o
> CMakeFiles/common-objs.dir/common/Formatter.cc.o
> CMakeFiles/common-objs.dir/common/HTMLFormatter.cc.o
> CMakeFiles/common-objs.dir/common/HeartbeatMap.cc.o
> CMakeFiles/common-objs.dir/common/PluginRegistry.cc.o
> CMakeFiles/common-objs.dir/common/ceph_fs.cc.o
> CMakeFiles/common-objs.dir/common/ceph_hash.cc.o
> CMakeFiles/common-objs.dir/common/ceph_strings.cc.o
> CMakeFiles/common-objs.dir/common/ceph_frag.cc.o
> CMakeFiles/common-objs.dir/common/config.cc.o
> CMakeFiles/common-objs.dir/common/config_validators.cc.o
> CMakeFiles/common-objs.dir/common/utf8.c.o
> CMakeFiles/common-objs.dir/common/mime.c.o
> CMakeFiles/common-objs.dir/common/strtol.cc.o
> CMakeFiles/common-objs.dir/common/page.cc.o
> CMakeFiles/common-objs.dir/common/lockdep.cc.o
> CMakeFiles/common-objs.dir/common/version.cc.o
> CMakeFiles/common-objs.dir/common/hex.cc.o
> CMakeFiles/common-objs.dir/common/entity_name.cc.o
> CMakeFiles/common-objs.dir/common/ceph_crypto.cc.o
> CMakeFiles/common-objs.dir/common/ceph_crypto_cms.cc.o
> CMakeFiles/common-objs.dir/common/ceph_json.cc.o
> CMakeFiles/common-objs.dir/common/ipaddr.cc.o
> CMakeFiles/common-objs.dir/common/pick_address.cc.o
> CMakeFiles/common-objs.dir/common/address_helper.cc.o
> CMakeFiles/common-objs.dir/common/linux_version.c.o
> CMakeFiles/common-objs.dir/common/TracepointProvider.cc.o
> CMakeFiles/common-objs.dir/common/Cycles.cc.o
> CMakeFiles/common-objs.dir/common/scrub_types.cc.o
> CMakeFiles/common-objs.dir/common/bit_str.cc.o
> CMakeFiles/common-objs.dir/osdc/Striper.cc.o
> CMakeFiles/common-objs.dir/osdc/Objecter.cc.o
> CMakeFiles/common-objs.dir/common/Graylog.cc.o
> CMakeFiles/common-objs.dir/common/fs_types.cc.o
> CMakeFiles/common-objs.dir/common/dns_resolve.cc.o
> CMakeFiles/common-objs.dir/common/hostname.cc.o
> CMakeFiles/common-objs.dir/common/util.cc.o
> CMakeFiles/common-objs.dir/arch/probe.cc.o
> CMakeFiles/common-objs.dir/auth/AuthAuthorizeHandler.cc.o
> CMakeFiles/common-objs.dir/auth/AuthClientHandler.cc.o
> CMakeFiles/common-objs.dir/auth/AuthSessionHandler.cc.o
> CMakeFiles/common-objs.dir/auth/AuthMethodList.cc.o
> CMakeFiles/common-objs.dir/auth/cephx/CephxAuthorizeHandler.cc.o
> CMakeFiles/common-objs.dir/auth/cephx/CephxClientHandler.cc.o
> CMakeFiles/common-objs.dir/auth/cephx/CephxProtocol.cc.o
> CMakeFiles/common-objs.dir/auth/cephx/CephxSessionHandler.cc.o
> CMakeFiles/common-objs.dir/auth/none/AuthNoneAuthorizeHandler.cc.o
> CMakeFiles/common-objs.dir/auth/unknown/AuthUnknownAuthorizeHandler.cc.o
> CMakeFiles/common-objs.dir/auth/Crypto.cc.o
> CMakeFiles/common-objs.dir/auth/KeyRing.cc.o
> CMakeFiles/common-objs.dir/auth/RotatingKeyRing.cc.o
> CMakeFiles/common-objs.dir/mds/MDSMap.cc.o
> CMakeFiles/common-objs.dir/mds/FSMap.cc.o
> CMakeFiles/common-objs.dir/mds/FSMapUser.cc.o
> CMakeFiles/common-objs.dir/mds/inode_backtrace.cc.o
> CMakeFiles/common-objs.dir/mds/mdstypes.cc.o
> CMakeFiles/common-objs.dir/mds/flock.cc.o
> CMakeFiles/common-objs.dir/arch/intel.c.o
> CMakeFiles/common-objs.dir/common/crc32c_intel_fast.c.o
> CMakeFiles/common-objs.dir/common/crc32c_intel_fast_asm.s.o
> CMakeFiles/common-objs.dir/common/crc32c_intel_fast_zero_asm.s.o
> CMakeFiles/common-objs.dir/msg/async/EventKqueue.cc.o
> CMakeFiles/common-objs.dir/perfglue/disabled_stubs.cc.o
> CMakeFiles/common_mountcephfs_objs.dir/common/armor.c.o
> CMakeFiles/common_mountcephfs_objs.dir/common/safe_io.c.o
> CMakeFiles/common_mountcephfs_objs.dir/common/module.c.o
> CMakeFiles/common_mountcephfs_objs.dir/common/addr_parsing.c.o
> global/CMakeFiles/global_common_objs.dir/global_context.cc.o
> CMakeFiles/crush_objs.dir/crush/builder.c.o
> CMakeFiles/crush_objs.dir/crush/mapper.c.o
> CMakeFiles/crush_objs.dir/crush/crush.c.o
> CMakeFiles/crush_objs.dir/crush/hash.c.o
> CMakeFiles/crush_objs.dir/crush/CrushWrapper.cc.o
> CMakeFiles/crush_objs.dir/crush/CrushCompiler.cc.o
> CMakeFiles/crush_objs.dir/crush/CrushTester.cc.o
> CMakeFiles/crush_objs.dir/crush/CrushLocation.cc.o  -L/usr/local/lib
> ../lib/libjson_spirit.a ../lib/liberasure_code.a -lrt -lBoost::thread
> -lBoost::system -lBoost::regex -lBoost::random -lBoost::program_options
> -lBoost::date_time -lBoost::iostreams -lexecinfo
> /usr/local/lib/nss/libssl3.so /usr/local/lib/nss/libsmime3.so
> /usr/local/lib/nss/libnss3.so /usr/local/lib/nss/libnssutil3.so
> /usr/local/lib/libplds4.so /usr/local/lib/libplc4.so
> /usr/local/lib/libnspr4.so -lpthread ../lib/libcommon_utf8.a
> -Wl,-rpath,/usr/local/lib:/usr/local/lib/nss:
> ccache /usr/bin/ar qc ../lib/libcommon.a
> CMakeFiles/common_buffer_obj.dir/common/buffer.cc.o
> CMakeFiles/common_texttable_obj.dir/common/TextTable.cc.o
> compressor/CMakeFiles/compressor_objs.dir/Compressor.cc.o
> compressor/CMakeFiles/compressor_objs.dir/AsyncCompressor.cc.o
> CMakeFiles/common-objs.dir/ceph_ver.c.o
> CMakeFiles/common-objs.dir/common/AsyncOpTracker.cc.o
> CMakeFiles/common-objs.dir/common/DecayCounter.cc.o
> CMakeFiles/common-objs.dir/common/LogClient.cc.o
> CMakeFiles/common-objs.dir/common/LogEntry.cc.o
> CMakeFiles/common-objs.dir/common/PrebufferedStreambuf.cc.o
> CMakeFiles/common-objs.dir/common/BackTrace.cc.o
> CMakeFiles/common-objs.dir/common/perf_counters.cc.o
> CMakeFiles/common-objs.dir/common/perf_histogram.cc.o
> CMakeFiles/common-objs.dir/common/mutex_debug.cc.o
> CMakeFiles/common-objs.dir/common/Mutex.cc.o
> CMakeFiles/common-objs.dir/common/OutputDataSocket.cc.o
> CMakeFiles/common-objs.dir/common/admin_socket.cc.o
> CMakeFiles/common-objs.dir/common/admin_socket_client.cc.o
> CMakeFiles/common-objs.dir/common/bloom_filter.cc.o
> CMakeFiles/common-objs.dir/common/Readahead.cc.o
> CMakeFiles/common-objs.dir/common/cmdparse.cc.o
> CMakeFiles/common-objs.dir/common/escape.c.o
> CMakeFiles/common-objs.dir/common/url_escape.cc.o
> CMakeFiles/common-objs.dir/common/io_priority.cc.o
> CMakeFiles/common-objs.dir/common/Clock.cc.o
> CMakeFiles/common-objs.dir/common/ceph_time.cc.o
> CMakeFiles/common-objs.dir/common/mempool.cc.o
> CMakeFiles/common-objs.dir/common/Throttle.cc.o
> CMakeFiles/common-objs.dir/common/Timer.cc.o
> CMakeFiles/common-objs.dir/common/Finisher.cc.o
> CMakeFiles/common-objs.dir/common/environment.cc.o
> CMakeFiles/common-objs.dir/common/sctp_crc32.c.o
> CMakeFiles/common-objs.dir/common/crc32c.cc.o
> CMakeFiles/common-objs.dir/common/crc32c_intel_baseline.c.o
> CMakeFiles/common-objs.dir/xxHash/xxhash.c.o
> CMakeFiles/common-objs.dir/common/assert.cc.o
> CMakeFiles/common-objs.dir/common/run_cmd.cc.o
> CMakeFiles/common-objs.dir/common/WorkQueue.cc.o
> CMakeFiles/common-objs.dir/common/ConfUtils.cc.o
> CMakeFiles/common-objs.dir/common/MemoryModel.cc.o
> CMakeFiles/common-objs.dir/common/fd.cc.o
> CMakeFiles/common-objs.dir/common/xattr.c.o
> CMakeFiles/common-objs.dir/common/str_list.cc.o
> CMakeFiles/common-objs.dir/common/str_map.cc.o
> CMakeFiles/common-objs.dir/common/snap_types.cc.o
> CMakeFiles/common-objs.dir/common/errno.cc.o
> CMakeFiles/common-objs.dir/common/TrackedOp.cc.o
> CMakeFiles/common-objs.dir/common/SloppyCRCMap.cc.o
> CMakeFiles/common-objs.dir/common/types.cc.o
> CMakeFiles/common-objs.dir/common/iso_8601.cc.o
> CMakeFiles/common-objs.dir/log/Log.cc.o
> CMakeFiles/common-objs.dir/log/SubsystemMap.cc.o
> CMakeFiles/common-objs.dir/mon/MonCap.cc.o
> CMakeFiles/common-objs.dir/mon/MonClient.cc.o
> CMakeFiles/common-objs.dir/mon/MonMap.cc.o
> CMakeFiles/common-objs.dir/mgr/MgrClient.cc.o
> CMakeFiles/common-objs.dir/msg/simple/Accepter.cc.o
> CMakeFiles/common-objs.dir/msg/DispatchQueue.cc.o
> CMakeFiles/common-objs.dir/msg/Message.cc.o
> CMakeFiles/common-objs.dir/mon/PGMap.cc.o
> CMakeFiles/common-objs.dir/osd/ECMsgTypes.cc.o
> CMakeFiles/common-objs.dir/osd/HitSet.cc.o
> CMakeFiles/common-objs.dir/common/RefCountedObj.cc.o
> CMakeFiles/common-objs.dir/msg/Messenger.cc.o
> CMakeFiles/common-objs.dir/msg/simple/Pipe.cc.o
> CMakeFiles/common-objs.dir/msg/simple/PipeConnection.cc.o
> CMakeFiles/common-objs.dir/msg/simple/SimpleMessenger.cc.o
> CMakeFiles/common-objs.dir/msg/async/AsyncConnection.cc.o
> CMakeFiles/common-objs.dir/msg/async/AsyncMessenger.cc.o
> CMakeFiles/common-objs.dir/msg/async/Event.cc.o
> CMakeFiles/common-objs.dir/msg/async/EventSelect.cc.o
> CMakeFiles/common-objs.dir/msg/async/Stack.cc.o
> CMakeFiles/common-objs.dir/msg/async/PosixStack.cc.o
> CMakeFiles/common-objs.dir/msg/async/net_handler.cc.o
> CMakeFiles/common-objs.dir/msg/QueueStrategy.cc.o
> CMakeFiles/common-objs.dir/msg/msg_types.cc.o
> CMakeFiles/common-objs.dir/common/reverse.c.o
> CMakeFiles/common-objs.dir/common/hobject.cc.o
> CMakeFiles/common-objs.dir/osd/OSDMap.cc.o
> CMakeFiles/common-objs.dir/osd/OSDMapMapping.cc.o
> CMakeFiles/common-objs.dir/common/histogram.cc.o
> CMakeFiles/common-objs.dir/osd/osd_types.cc.o
> CMakeFiles/common-objs.dir/osd/OpRequest.cc.o
> CMakeFiles/common-objs.dir/common/blkdev.cc.o
> CMakeFiles/common-objs.dir/common/common_init.cc.o
> CMakeFiles/common-objs.dir/common/pipe.c.o
> CMakeFiles/common-objs.dir/common/ceph_argparse.cc.o
> CMakeFiles/common-objs.dir/common/ceph_context.cc.o
> CMakeFiles/common-objs.dir/common/code_environment.cc.o
> CMakeFiles/common-objs.dir/common/dout.cc.o
> CMakeFiles/common-objs.dir/common/signal.cc.o
> CMakeFiles/common-objs.dir/common/Thread.cc.o
> CMakeFiles/common-objs.dir/common/Formatter.cc.o
> CMakeFiles/common-objs.dir/common/HTMLFormatter.cc.o
> CMakeFiles/common-objs.dir/common/HeartbeatMap.cc.o
> CMakeFiles/common-objs.dir/common/PluginRegistry.cc.o
> CMakeFiles/common-objs.dir/common/ceph_fs.cc.o
> CMakeFiles/common-objs.dir/common/ceph_hash.cc.o
> CMakeFiles/common-objs.dir/common/ceph_strings.cc.o
> CMakeFiles/common-objs.dir/common/ceph_frag.cc.o
> CMakeFiles/common-objs.dir/common/config.cc.o
> CMakeFiles/common-objs.dir/common/config_validators.cc.o
> CMakeFiles/common-objs.dir/common/utf8.c.o
> CMakeFiles/common-objs.dir/common/mime.c.o
> CMakeFiles/common-objs.dir/common/strtol.cc.o
> CMakeFiles/common-objs.dir/common/page.cc.o
> CMakeFiles/common-objs.dir/common/lockdep.cc.o
> CMakeFiles/common-objs.dir/common/version.cc.o
> CMakeFiles/common-objs.dir/common/hex.cc.o
> CMakeFiles/common-objs.dir/common/entity_name.cc.o
> CMakeFiles/common-objs.dir/common/ceph_crypto.cc.o
> CMakeFiles/common-objs.dir/common/ceph_crypto_cms.cc.o
> CMakeFiles/common-objs.dir/common/ceph_json.cc.o
> CMakeFiles/common-objs.dir/common/ipaddr.cc.o
> CMakeFiles/common-objs.dir/common/pick_address.cc.o
> CMakeFiles/common-objs.dir/common/address_helper.cc.o
> CMakeFiles/common-objs.dir/common/linux_version.c.o
> CMakeFiles/common-objs.dir/common/TracepointProvider.cc.o
> CMakeFiles/common-objs.dir/common/Cycles.cc.o
> CMakeFiles/common-objs.dir/common/scrub_types.cc.o
> CMakeFiles/common-objs.dir/common/bit_str.cc.o
> CMakeFiles/common-objs.dir/osdc/Striper.cc.o
> CMakeFiles/common-objs.dir/osdc/Objecter.cc.o
> CMakeFiles/common-objs.dir/common/Graylog.cc.o
> CMakeFiles/common-objs.dir/common/fs_types.cc.o
> CMakeFiles/common-objs.dir/common/dns_resolve.cc.o
> CMakeFiles/common-objs.dir/common/hostname.cc.o
> CMakeFiles/common-objs.dir/common/util.cc.o
> CMakeFiles/common-objs.dir/arch/probe.cc.o
> CMakeFiles/common-objs.dir/auth/AuthAuthorizeHandler.cc.o
> CMakeFiles/common-objs.dir/auth/AuthClientHandler.cc.o
> CMakeFiles/common-objs.dir/auth/AuthSessionHandler.cc.o
> CMakeFiles/common-objs.dir/auth/AuthMethodList.cc.o
> CMakeFiles/common-objs.dir/auth/cephx/CephxAuthorizeHandler.cc.o
> CMakeFiles/common-objs.dir/auth/cephx/CephxClientHandler.cc.o
> CMakeFiles/common-objs.dir/auth/cephx/CephxProtocol.cc.o
> CMakeFiles/common-objs.dir/auth/cephx/CephxSessionHandler.cc.o
> CMakeFiles/common-objs.dir/auth/none/AuthNoneAuthorizeHandler.cc.o
> CMakeFiles/common-objs.dir/auth/unknown/AuthUnknownAuthorizeHandler.cc.o
> CMakeFiles/common-objs.dir/auth/Crypto.cc.o
> CMakeFiles/common-objs.dir/auth/KeyRing.cc.o
> CMakeFiles/common-objs.dir/auth/RotatingKeyRing.cc.o
> CMakeFiles/common-objs.dir/mds/MDSMap.cc.o
> CMakeFiles/common-objs.dir/mds/FSMap.cc.o
> CMakeFiles/common-objs.dir/mds/FSMapUser.cc.o
> CMakeFiles/common-objs.dir/mds/inode_backtrace.cc.o
> CMakeFiles/common-objs.dir/mds/mdstypes.cc.o
> CMakeFiles/common-objs.dir/mds/flock.cc.o
> CMakeFiles/common-objs.dir/arch/intel.c.o
> CMakeFiles/common-objs.dir/common/crc32c_intel_fast.c.o
> CMakeFiles/common-objs.dir/common/crc32c_intel_fast_asm.s.o
> CMakeFiles/common-objs.dir/common/crc32c_intel_fast_zero_asm.s.o
> CMakeFiles/common-objs.dir/msg/async/EventKqueue.cc.o
> CMakeFiles/common-objs.dir/perfglue/disabled_stubs.cc.o
> CMakeFiles/common_mountcephfs_objs.dir/common/armor.c.o
> CMakeFiles/common_mountcephfs_objs.dir/common/safe_io.c.o
> CMakeFiles/common_mountcephfs_objs.dir/common/module.c.o
> CMakeFiles/common_mountcephfs_objs.dir/common/addr_parsing.c.o
> global/CMakeFiles/global_common_objs.dir/global_context.cc.o
> CMakeFiles/crush_objs.dir/crush/builder.c.o
> CMakeFiles/crush_objs.dir/crush/mapper.c.o
> CMakeFiles/crush_objs.dir/crush/crush.c.o
> CMakeFiles/crush_objs.dir/crush/hash.c.o
> CMakeFiles/crush_objs.dir/crush/CrushWrapper.cc.o
> CMakeFiles/crush_objs.dir/crush/CrushCompiler.cc.o
> CMakeFiles/crush_objs.dir/crush/CrushTester.cc.o
> CMakeFiles/crush_objs.dir/crush/CrushLocation.cc.o
> gmake[2]: Leaving directory '/home/jenkins/workspace/ceph-master/build'
> [ 39%] Built target rbd_mirror_internal
> /usr/bin/ld: cannot find -lBoost::thread
> c++: error: linker command failed with exit code 1 (use -v to see
> invocation)
> gmake[2]: *** [src/CMakeFiles/ceph-common.dir/build.make:414:
> lib/libceph-common.so.0] Error 1
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

