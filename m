From: Xiaoxi Chen <superdebuger@gmail.com>
Subject: prefered behavior for injecting untracked args
Date: Tue, 28 Jun 2016 23:23:39 +0800
Message-ID: <CAEYCsVJz9b8fDdEz8V7iraoq6t6wtY8ddt4XqBnxEVmvAcLnfA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qk0-f177.google.com ([209.85.220.177]:33397 "EHLO
	mail-qk0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752175AbcF1PXl (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 28 Jun 2016 11:23:41 -0400
Received: by mail-qk0-f177.google.com with SMTP id q79so35651140qke.0
        for <ceph-devel@vger.kernel.org>; Tue, 28 Jun 2016 08:23:40 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

Hi,

   In jewel , when handling "inject-args" command, monitor will report
"unchangeable" for those non-tracking args, nevertheless, the config
is still updated. as "ceph daemon config show " will give out the new
value.

     It looks to me like if the configuration is not dynamically
changeable, we may better NOT to update the config? as the config set
by injectargs is not persist to disk , so before reboot the daemon,
config will not take effect, after reboot the daemon, config will
lost...it doesnt work(i.e make the config change) anyway.

    We notice this because we had an accident on our network switch so
lots of the OSD down and out, and we would intent to speed up the
recovery, then we inject "osd_recovery_max_active= 10" and got
"unchangeable", but in admin socket we can see this configuration so
we assume it is working but actually not. My point is the non-tracking
args showing in admin socket config dump is really misleading, other
guys will never know whether the args in config dump is make effect if
they don't know how this is set, via admin socket or via configuration
files.

    Kefu and I had some discussion on the original PR and would like
to here more opinions, See pr for more background:
https://github.com/ceph/ceph/pull/7085.

    Thanks for the input.

Xiaoxi
