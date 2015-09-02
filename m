From: Noah Watkins <noahwatkins@gmail.com>
Subject: ceph-deploy: too many argument: --setgroup 10
Date: Wed, 2 Sep 2015 14:59:52 -0600
Message-ID: <CAB2gnbV3LxJYxSxnz7J8ZsXxPkjhy7Ba5aN834nrFwzG-QyNOw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qk0-f177.google.com ([209.85.220.177]:36339 "EHLO
	mail-qk0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932314AbbIBU7x (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 2 Sep 2015 16:59:53 -0400
Received: by qkcf65 with SMTP id f65so13026108qkc.3
        for <ceph-devel@vger.kernel.org>; Wed, 02 Sep 2015 13:59:52 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>
Cc: ceph-users <ceph-users@ceph.com>

I'm getting the following error using ceph-deploy to setup a cluster.
It's Centos6.6 and I'm using Hammer and the latest ceph-deploy. It
looks like setgroup wasn't an option in Hammer, but ceph-deploy adds
it. Is there a trick or older version of ceph-deploy I should try?

- Noah

[cn67][INFO  ] Running command: sudo ceph-mon --cluster ceph --mkfs -i
cn67 --keyring /var/lib/ceph/tmp/ceph-cn67.mon.keyring --setgroup 10
[cn67][WARNIN] too many arguments: [--setgroup,10]
[cn67][DEBUG ]   --conf/-c FILE    read configuration from the given
configuration file
[cn67][WARNIN] usage: ceph-mon -i monid [flags]
[cn67][DEBUG ]   --id/-i ID        set ID portion of my name
[cn67][WARNIN]   --debug_mon n
[cn67][DEBUG ]   --name/-n TYPE.ID set name
[cn67][WARNIN]         debug monitor level (e.g. 10)
[cn67][DEBUG ]   --cluster NAME    set cluster name (default: ceph)
[cn67][WARNIN]   --mkfs
[cn67][DEBUG ]   --version         show version and quit
[cn67][WARNIN]         build fresh monitor fs
[cn67][DEBUG ]
[cn67][WARNIN]   --force-sync
[cn67][DEBUG ]   -d                run in foreground, log to stderr.
[cn67][WARNIN]         force a sync from another mon by wiping local
data (BE CAREFUL)
[cn67][DEBUG ]   -f                run in foreground, log to usual location.
[cn67][WARNIN]   --yes-i-really-mean-it
[cn67][DEBUG ]   --debug_ms N      set message debug level (e.g. 1)
[cn67][WARNIN]         mandatory safeguard for --force-sync
[cn67][WARNIN]   --compact
[cn67][WARNIN]         compact the monitor store
[cn67][WARNIN]   --osdmap <filename>
[cn67][WARNIN]         only used when --mkfs is provided: load the
osdmap from <filename>
[cn67][WARNIN]   --inject-monmap <filename>
[cn67][WARNIN]         write the <filename> monmap to the local
monitor store and exit
[cn67][WARNIN]   --extract-monmap <filename>
[cn67][WARNIN]         extract the monmap from the local monitor store and exit
[cn67][WARNIN]   --mon-data <directory>
[cn67][WARNIN]         where the mon store and keyring are located
[cn67][ERROR ] RuntimeError: command returned non-zero exit status: 1
[ceph_deploy.mon][ERROR ] Failed to execute command: ceph-mon
--cluster ceph --mkfs -i cn67 --keyring
/var/lib/ceph/tmp/ceph-cn67.mon.keyring --setgroup 10
[ceph_deploy][ERROR ] GenericError: Failed to create 1 monitors
