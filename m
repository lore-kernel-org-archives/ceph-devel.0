From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Re: FreeBSD is not running atexit in ceph-mon
Date: Sun, 14 Feb 2016 14:08:22 +0100
Message-ID: <56C07C46.4040708@digiware.nl>
References: <56BF5546.7070309@digiware.nl> <56BF6709.4040701@dachary.org>
 <56BF79B0.7070505@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([31.223.170.169]:15055 "EHLO smtp.digiware.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751312AbcBNNIj (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sun, 14 Feb 2016 08:08:39 -0500
In-Reply-To: <56BF79B0.7070505@digiware.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>, ceph-devel <ceph-devel@vger.kernel.org>

On 13-2-2016 19:45, Willem Jan Withagen wrote:
> On 13-2-2016 18:25, Loic Dachary wrote:
>> Hi,
>>
>> There has been recent change to the pidfile implementation
>>
>> http://tracker.ceph.com/issues/13422 has https://github.com/ceph/ceph/pull/7075 and https://github.com/ceph/ceph/pull/7463

These pulls have been comitted and I'm running ith this code installed.
I've annotated the pidfile exit code with some stderr logging
And I saw some of the ceph-mon output, so the code is working.

The problem is only that it is not always called when programs are
terminated by signals...

--WjW

> Thanx for pointing me to these pulls....
> The discussion about these changes was quite long, and I do remember
> that there were some serious arguments about correctness, etc...
> 
> I thought that code was commited, but if they are still pulls
> I'm certainly not running them. I'll check them out.
> 
> However I find it rather complex to test something as 'simple' as this,
> in the convoluted why of completely firing up a ceph-mon or ceph-osd
> daemon. Creating a small deamon without actual content, other than
> running while(1) {sleep(1)} would make things way much beter debugable.
> 
> But that sort leaves the question standing why I'm not running the
> atexit code.
> 
> --WjW
> 
>>
>> is this what you're running or something else ?
>>
>> Cheers
>>
>> On 13/02/2016 23:09, Willem Jan Withagen wrote:
>>> Hi,
>>>
>>> I've been banging my head against the wall for 2 days now...
>>>
>>> I've augmented the global/pidfile.cc code to print a string to
>>> stderr once the pidfile_remove() code is called.
>>>
>>> Below is the output from the moment a signal is received on both
>>> platforms. On Linux there is a lot more work doen, as is on FreeBSD,
>>> which bothers me....
>>>
>>> But the most important part is that the atexit code is not executed.
>>> And as a consequence of that the PID file is not removed.
>>>
>>> The most obvious would be that the FreeBSD version crashes while
>>> exiting. But there is no core file as indication for that.
>>>
>>> Does anybody have suggestions as to why the FreeBSD variant would not be
>>> executing the atexit pushed routines.
>>>
>>> --WjW
>>>
>>> Comamnd run:
>>> ceph-mon -d --id a --mon-osd-full-ratio=.99 --mon-data-avail-crit=1
>>> --paxos-propose-interval=0.1 --osd-crush-chooseleaf-type=0
>>> --erasure-code-dir=.libs --plugin-dir=.libs --debug-mon 20 --debug-ms 20
>>> --debug-paxos 20 --chdir= --mon-data=testdir/pidfile/a
>>> '--log-file=testdir/pidfile/$name.log'
>>> '--admin-socket=testdir/pidfile/$cluster-$name.asok'
>>> --mon-cluster-log-file=testdir/pidfile/log --run-dir=testdir/pidfile
>>> '--pid-file=testdir/pidfile/$name.pid'
>>>
>>> On Linux/Centos7 this gives:
>>> ====
>>> 2016-02-13 16:38:45.431348 7fe459e2d480 10 -- 127.0.0.1:7124/0 wait: done.
>>> 2016-02-13 16:38:45.431353 7fe459e2d480  1 -- 127.0.0.1:7124/0 shutdown
>>> complete.
>>> pidfile_remove: run at exit.
>>> 2016-02-13 16:38:45.388430 7fe450df1700 -1 mon.a@0(leader) e1 *** Got
>>> Signal Terminated ***
>>> 2016-02-13 16:38:45.388462 7fe450df1700  1 mon.a@0(leader) e1 shutdown
>>> 2016-02-13 16:38:45.388489 7fe452df5700 10 mon.a@0(leader).auth v4
>>> check_rotate updated rotating
>>> 2016-02-13 16:38:45.388510 7fe452df5700 10
>>> mon.a@0(leader).paxosservice(auth 1..4) propose_pending
>>> 2016-02-13 16:38:45.389062 7fe452df5700 10 mon.a@0(leader).auth v4
>>> encode_pending v 5
>>> 2016-02-13 16:38:45.389129 7fe452df5700  5 mon.a@0(leader).paxos(paxos
>>> active c 1..44) queue_pending_finisher 0x7fe464bbc430
>>> 2016-02-13 16:38:45.389136 7fe452df5700 10 mon.a@0(leader).paxos(paxos
>>> active c 1..44) trigger_propose active, proposing now
>>> 2016-02-13 16:38:45.389150 7fe452df5700 10 mon.a@0(leader).paxos(paxos
>>> active c 1..44) propose_pending 45 801 bytes
>>> 2016-02-13 16:38:45.389157 7fe452df5700 10 mon.a@0(leader).paxos(paxos
>>> updating c 1..44) begin for 45 801 bytes
>>> 2016-02-13 16:38:45.410897 7fe452df5700 10 mon.a@0(leader).paxos(paxos
>>> updating c 1..44) commit_start 45
>>> 2016-02-13 16:38:45.411038 7fe452df5700 20 mon.a@0(leader) e1
>>> sync_trim_providers
>>> 2016-02-13 16:38:45.411129 7fe450df1700 10 mon.a@0(leader) e1
>>> wait_for_paxos_write flushing pending write
>>> 2016-02-13 16:38:45.428867 7fe453df7700 20 mon.a@0(leader).paxos(paxos
>>> writing c 1..44) commit_finish 45
>>> 2016-02-13 16:38:45.428962 7fe453df7700 10 mon.a@0(leader) e1
>>> refresh_from_paxos
>>> 2016-02-13 16:38:45.429013 7fe453df7700 10
>>> mon.a@0(leader).paxosservice(pgmap 1..11) refresh
>>> 2016-02-13 16:38:45.429049 7fe453df7700 10
>>> mon.a@0(leader).paxosservice(mdsmap 1..1) refresh
>>> 2016-02-13 16:38:45.429083 7fe453df7700 10
>>> mon.a@0(leader).paxosservice(osdmap 1..10) refresh
>>> 2016-02-13 16:38:45.429116 7fe453df7700 10
>>> mon.a@0(leader).paxosservice(logm 1..24) refresh
>>> 2016-02-13 16:38:45.429119 7fe453df7700 10 mon.a@0(leader).log v24
>>> update_from_paxos
>>> 2016-02-13 16:38:45.429122 7fe453df7700 10 mon.a@0(leader).log v24
>>> update_from_paxos version 24 summary v 24
>>> 2016-02-13 16:38:45.429157 7fe453df7700 10
>>> mon.a@0(leader).paxosservice(monmap 1..1) refresh
>>> 2016-02-13 16:38:45.429189 7fe453df7700 10
>>> mon.a@0(leader).paxosservice(auth 1..5) refresh
>>> 2016-02-13 16:38:45.429192 7fe453df7700 10 mon.a@0(leader).auth v5
>>> update_from_paxos
>>> 2016-02-13 16:38:45.429206 7fe453df7700 10 mon.a@0(leader).auth v5
>>> update_from_paxos version 5 keys ver 4 latest 1
>>> 2016-02-13 16:38:45.429209 7fe453df7700 10 mon.a@0(leader).auth v5
>>> update_from_paxos key server version 4
>>> 2016-02-13 16:38:45.429227 7fe453df7700 20 mon.a@0(leader).auth v5
>>> update_from_paxos walking through version 5 len 649
>>> 2016-02-13 16:38:45.429502 7fe453df7700 10 mon.a@0(leader).auth v5
>>> update_from_paxos() last_allocated_id=14096 max_global_id=14096
>>> format_version 1
>>> 2016-02-13 16:38:45.429514 7fe453df7700 10
>>> mon.a@0(leader).paxosservice(pgmap 1..11) post_refresh
>>> 2016-02-13 16:38:45.429518 7fe453df7700 10 mon.a@0(leader).pg v11
>>> post_paxos_update
>>> 2016-02-13 16:38:45.429523 7fe453df7700 10 mon.a@0(leader).pg v11 check_subs
>>> 2016-02-13 16:38:45.429524 7fe453df7700 10
>>> mon.a@0(leader).paxosservice(mdsmap 1..1) post_refresh
>>> 2016-02-13 16:38:45.429526 7fe453df7700 10
>>> mon.a@0(leader).paxosservice(osdmap 1..10) post_refresh
>>> 2016-02-13 16:38:45.429529 7fe453df7700 10
>>> mon.a@0(leader).paxosservice(logm 1..24) post_refresh
>>> 2016-02-13 16:38:45.429530 7fe453df7700 10
>>> mon.a@0(leader).paxosservice(monmap 1..1) post_refresh
>>> 2016-02-13 16:38:45.429532 7fe453df7700 10
>>> mon.a@0(leader).paxosservice(auth 1..5) post_refresh
>>> 2016-02-13 16:38:45.429536 7fe453df7700 10 mon.a@0(leader).paxos(paxos
>>> refresh c 1..45) commit_proposal
>>> 2016-02-13 16:38:45.429544 7fe453df7700 10
>>> mon.a@0(leader).paxosservice(auth 1..5) _active - not active
>>> 2016-02-13 16:38:45.429550 7fe453df7700 10 mon.a@0(leader).paxos(paxos
>>> refresh c 1..45) finish_round
>>> 2016-02-13 16:38:45.429550 7fe453df7700 20 mon.a@0(leader).paxos(paxos
>>> active c 1..45) finish_round waiting_for_acting
>>> 2016-02-13 16:38:45.429554 7fe453df7700 10
>>> mon.a@0(leader).paxosservice(auth 1..5) _active
>>> 2016-02-13 16:38:45.429554 7fe453df7700 10
>>> mon.a@0(leader).paxosservice(auth 1..5) remove_legacy_versions
>>> 2016-02-13 16:38:45.429568 7fe453df7700  7
>>> mon.a@0(leader).paxosservice(auth 1..5) _active creating new pending
>>> 2016-02-13 16:38:45.429574 7fe453df7700 10 mon.a@0(leader).auth v5
>>> create_pending v 6
>>> 2016-02-13 16:38:45.429576 7fe453df7700 20 mon.a@0(leader).auth v5
>>> upgrade_format format 1 is current
>>> 2016-02-13 16:38:45.429579 7fe453df7700 10 mon.a@0(leader).auth v5
>>> AuthMonitor::on_active()
>>> 2016-02-13 16:38:45.429587 7fe453df7700 20 mon.a@0(leader).paxos(paxos
>>> active c 1..45) finish_round waiting_for_readable
>>> 2016-02-13 16:38:45.429587 7fe453df7700 20 mon.a@0(leader).paxos(paxos
>>> active c 1..45) finish_round waiting_for_writeable
>>> 2016-02-13 16:38:45.429590 7fe453df7700 10 mon.a@0(leader).paxos(paxos
>>> active c 1..45) finish_round done w/ waiters, state 1
>>> 2016-02-13 16:38:45.429675 7fe450df1700 10 mon.a@0(leader) e1
>>> wait_for_paxos_write flushed pending write
>>> 2016-02-13 16:38:45.429801 7fe450df1700 10 mon.a@0(shutdown).paxos(paxos
>>> active c 1..45) shutdown cancel all contexts
>>> 2016-02-13 16:38:45.429828 7fe450df1700 10 mon.a@0(shutdown).osd e10
>>> on_shutdown
>>> 2016-02-13 16:38:45.429863 7fe450df1700 10 mon.a@0(shutdown).osd e10
>>> take_all_failures on 0 osds
>>> 2016-02-13 16:38:45.429877 7fe450df1700  0 quorum service shutdown
>>> 2016-02-13 16:38:45.429881 7fe450df1700  0 mon.a@0(shutdown).health(5)
>>> HealthMonitor::service_shutdown 1 services
>>> 2016-02-13 16:38:45.429887 7fe450df1700  0 quorum service shutdown
>>> 2016-02-13 16:38:45.430211 7fe450df1700 10 mon.a@0(shutdown) e1
>>> remove_session 0x7fe464c18e00 mon.0 127.0.0.1:7124/0
>>> 2016-02-13 16:38:45.430286 7fe450df1700 10 -- 127.0.0.1:7124/0 shutdown
>>> 127.0.0.1:7124/0
>>> 2016-02-13 16:38:45.430339 7fe450df1700  1 -- 127.0.0.1:7124/0 mark_down_all
>>> 2016-02-13 16:38:45.430503 7fe459e2d480 10 -- 127.0.0.1:7124/0 wait:
>>> dispatch queue is stopped
>>> 2016-02-13 16:38:45.430532 7fe459e2d480 20 -- 127.0.0.1:7124/0 wait:
>>> stopping accepter thread
>>> 2016-02-13 16:38:45.430539 7fe459e2d480 10 accepter.stop accepter
>>> 2016-02-13 16:38:45.430700 7fe4515f2700 20 accepter.accepter poll got 1
>>> 2016-02-13 16:38:45.430722 7fe4515f2700 20 accepter.accepter closing
>>> 2016-02-13 16:38:45.430761 7fe4515f2700 10 accepter.accepter stopping
>>> 2016-02-13 16:38:45.431000 7fe459e2d480 20 -- 127.0.0.1:7124/0 wait:
>>> stopped accepter thread
>>> 2016-02-13 16:38:45.431021 7fe459e2d480 20 -- 127.0.0.1:7124/0 wait:
>>> stopping reaper thread
>>> 2016-02-13 16:38:45.431092 7fe4535f6700 10 -- 127.0.0.1:7124/0
>>> reaper_entry done
>>> 2016-02-13 16:38:45.431273 7fe459e2d480 20 -- 127.0.0.1:7124/0 wait:
>>> stopped reaper thread
>>> 2016-02-13 16:38:45.431295 7fe459e2d480 10 -- 127.0.0.1:7124/0 wait:
>>> closing pipes
>>> 2016-02-13 16:38:45.431331 7fe459e2d480 10 -- 127.0.0.1:7124/0 reaper
>>> 2016-02-13 16:38:45.431337 7fe459e2d480 10 -- 127.0.0.1:7124/0 reaper done
>>> 2016-02-13 16:38:45.431343 7fe459e2d480 10 -- 127.0.0.1:7124/0 wait:
>>> waiting for pipes  to close
>>> 2016-02-13 16:38:45.431348 7fe459e2d480 10 -- 127.0.0.1:7124/0 wait: done.
>>> 2016-02-13 16:38:45.431353 7fe459e2d480  1 -- 127.0.0.1:7124/0 shutdown
>>> complete.
>>> pidfile_remove: run at exit.
>>> remove: Removing PID: 15196 in file testdir/pidfile/mon.a.pid
>>> remove: Removing PID: 15196 file: testdir/pidfile/mon.a.pid
>>> ====
>>>
>>> Running the same code in the same mode on FreeBSD gives as termination:
>>> ====
>>> 2016-02-13 16:46:48.152618 804cdc800 -1 mon.a@0(leader) e1 *** Got
>>> Signal Terminated ***
>>> 2016-02-13 16:46:48.152650 804cdc800  1 mon.a@0(leader) e1 shutdown
>>> 2016-02-13 16:46:48.152747 804cdc800 10 mon.a@0(shutdown).paxos(paxos
>>> active c 1..10) shutdown cancel all contexts
>>> 2016-02-13 16:46:48.152771 804cdc800 10 mon.a@0(shutdown).osd e1 on_shutdown
>>> 2016-02-13 16:46:48.152776 804cdc800 10 mon.a@0(shutdown).osd e1
>>> take_all_failures on 0 osds
>>> 2016-02-13 16:46:48.152789 804cdc800  0 quorum service shutdown
>>> 2016-02-13 16:46:48.152792 804cdc800  0 mon.a@0(shutdown).health(5)
>>> HealthMonitor::service_shutdown 1 services
>>> 2016-02-13 16:46:48.152799 804cdc800  0 quorum service shutdown
>>> 2016-02-13 16:46:48.153028 804cdc800 10 mon.a@0(shutdown) e1
>>> remove_session 0x80741f000 mon.0 127.0.0.1:7124/0
>>> 2016-02-13 16:46:48.153067 804cdc800 10 -- 127.0.0.1:7124/0 shutdown
>>> 127.0.0.1:7124/0
>>> 2016-02-13 16:46:48.153074 804cdc800  1 -- 127.0.0.1:7124/0 mark_down_all
>>> 2016-02-13 16:46:48.153171 804c15000 10 -- 127.0.0.1:7124/0 wait:
>>> dispatch queue is stopped
>>> 2016-02-13 16:46:48.153194 804c15000 20 -- 127.0.0.1:7124/0 wait:
>>> stopping accepter thread
>>> ====
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>
>>
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

