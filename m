From: Ta Ba Tuan <tuantb-QlevPasa8l681eZEIcUDRw@public.gmane.org>
Subject: Re: Can't start osd- one osd alway be down.
Date: Sat, 25 Oct 2014 21:57:59 +0700
Message-ID: <544BBA77.8040900@vccloud.vn>
References: <5449E1E3.7030606@vccloud.vn>
	<CADHZLBaU6LrQN+Y7JKfx9LLaHBmVZKVccNb90Z17nZZrjiharg@mail.gmail.com>
	<544B2672.6030604@vccloud.vn> <544B58D5.6080902@vccloud.vn>
	<544B9A59.4020502@vccloud.vn>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0541794296=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <544B9A59.4020502-QlevPasa8l681eZEIcUDRw@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org, "ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

This is a multi-part message in MIME format.
--===============0541794296==
Content-Type: multipart/alternative;
 boundary="------------020602070300070406020506"

This is a multi-part message in MIME format.
--------------020602070300070406020506
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

#ceph pg *6.9d8* query
...
   "peer_info": [
         { "peer": "49",
           "pgid": "6.9d8",
           "last_update": "102889'7801917",
           "last_complete": "102889'7801917",
           "log_tail": "102377'7792649",
           "last_user_version": 7801879,
           "last_backfill": "MAX",
           "purged_snaps": 
"[1~7,9~44b,455~1f8,64f~63,6b3~3a,6ee~12f,81f~10,830~8,839~69b,ed7~7,edf~4,ee4~6f5,15da~f9,16d4~1f,16f5~7,16fd~4,1705~5
e,1764~7,1771~78,17eb~12,1800~2,1803~d,1812~3,181a~1,181c~a,1827~3b,1863~1,1865~1,1867~1,186b~e,187a~3,1881~1,1884~7,188c~1,188f~3,1894~5,189f~2,
18ab~1,18c6~1,1922~13,193d~1,1940~1,194a~1,1968~5,1975~1,1979~4,197e~4,1984~1,1987~11,199c~1,19a0~1,19a3~9,19ad~3,19b2~1,19b6~27,19de~8]",
           "history": { "epoch_created": 164,
               "last_epoch_started": 102888,
               "last_epoch_clean": 102888,
               "last_epoch_split": 0
               "parent_split_bits": 0,
               "last_scrub": "91654'7460936",
               "last_scrub_stamp": "2014-10-10 10:36:25.433016",
               "last_deep_scrub": "81667'5815892",
               "last_deep_scrub_stamp": "2014-08-29 09:44:14.012219",
               "last_clean_scrub_stamp": "2014-10-10 10:36:25.433016",
               "log_size": 9229,
               "ondisk_log_size": 9229,
               "stats_invalid": "1",
               "stat_sum": { "num_bytes": 17870536192,
                   "num_objects": 4327,
                   "num_object_clones": 29,
                   "num_object_copies": 12981,*
**                  "num_objects_missing_on_primary": 4,*
                   "num_objects_degraded": 4,
                   "num_objects_unfound": 0,
                   "num_objects_dirty": 1092,
                   "num_whiteouts": 0,
                   "num_read": 4820626,
                   "num_read_kb": 59073045,
                   "num_write": 12748709,
                   "num_write_kb": 181630845,
                   "num_scrub_errors": 0,
                   "num_shallow_scrub_errors": 0,
                   "num_deep_scrub_errors": 0,
                   "num_objects_recovered": 135847,
                   "num_bytes_recovered": 562255538176,
                   "num_keys_recovered": 0,
                   "num_objects_omap": 0,
                   "num_objects_hit_set_archive": 0},


On 10/25/2014 07:40 PM, Ta Ba Tuan wrote:
> My Ceph was hung, and    "osd.21 172.30.5.2:6870/8047 879 : [ERR] 
> 6.9d8 has 4 objects unfound and apparently lost".
>
> After I restart all ceph-data nodes,  I can't start osd.21, have many 
> logs about pg 6.9d8 as:
>
>  -440> 2014-10-25 19:28:17.468161 7fec5731d700  5 -- op tracker -- 
> seq: 3083, time: 2014-10-25 19:28:17.468161, event: reached_pg, op: 
> MOSDPGPus
> h(*6.9d8* 102856 
> [PushOp(e8de59d8/*rbd_data.4d091f7304c844.000000000000e871/head//6*, 
> version: 102853'7800592, data_included: [0~4194304], data_size:
>  4194304, omap_header_size: 0, omap_entries_size: 0, attrset_size: 2, 
> recovery_info: 
> ObjectRecoveryInfo(e8de59d8/rbd_data.4d091f7304c844.00000000
> 0000e871/head//6@102853'7800592, copy_subset: [0~4194304], 
> clone_subset: {}), after_progress: ObjectRecoveryProgress(!first, 
> data_recovered_to:41
> 94304, data_complete:true, omap_recovered_to:, omap_complete:true), 
> before_progress: ObjectRecoveryProgress(first, data_recovered_to:0, 
> data_comp
> lete:false, omap_recovered_to:, omap_complete:false))])
>
> I think having some error objects. What'm I must do?,please!
> Thanks!
> --
> Tuan
> HaNoi-VietNam
>
>
> On 10/25/2014 03:01 PM, Ta Ba Tuan wrote:
>> I send some related bugs:
>> (osd.21 not be able started)
>>
>>  -8705> 2014-10-25 14:41:04.345727 7f12bac2f700  5 *osd.21* pg_epoch: 
>> 102843 pg[*6.5e1*( v 102843'11832159 
>> (102377'11822991,102843'11832159] lb 
>> c4951de1/rbd_data.3955c5cdbb2ea.00000000000405f0/head//6 
>> local-les=101780 n=4719 ec=164 les/c 102841/102838 
>> 102840/102840/102477) [40,0,21]/[40,0,60] r=-1 lpr=102840 
>> pi=31832-102839/230 luod=0'0 crt=102843'11832157 lcod 102843'11832158 
>> active+remapped] *exit Started/ReplicaActive/RepNotRecovering* 
>> 0.000170 1 0.000296
>>
>>  -1637> 2014-10-25 14:41:14.326580 7f12bac2f700  5 *osd.21* pg_epoch: 
>> 102843 pg[*2.23b*( v 102839'91984 (91680'88526,102839'91984] 
>> local-les=102841 n=85 ec=25000 les/c 102841/102838 
>> 102840/102840/102656) [90,21,120] r=1 lpr=102840 pi=100114-102839/50 
>> luod=0'0 crt=102839'91984 active] *enter 
>> Started/ReplicaActive/RepNotRecovering*
>>
>>   -437> 2014-10-25 14:41:15.042174 7f12ba42e700  5 *osd.21 *pg_epoch: 
>> 102843 pg[*27.239(* v 102808'38419 (81621'35409,102808'38419] 
>> local-les=102841 n=23 ec=25085 les/c 102841/102838 
>> 102840/102840/102656) [90,21,120] r=1 lpr=102840 pi=100252-102839/53 
>> luod=0'0 crt=102808'38419 active] *enter 
>> **Started/ReplicaActive/RepNotRecovering*
>>
>> Thanks!
>>
>>
>> On 10/25/2014 11:26 AM, Ta Ba Tuan wrote:
>>> Hi Craig, Thanks for replying.
>>> When i started that osd, Ceph Log from "ceph -w" warns pgs 7.9d8 
>>> 23.596, 23.9c6, 23.63 can't recovery as pasted log.
>>>
>>> Those pgs are "active+degraded" state.
>>> #ceph pg map 7.9d8
>>> osdmap e102808 pg 7.9d8 (7.9d8) -> up [93,49] acting [93,49]  (When 
>>> start osd.21 then pg 7.9d8 and three remain pgs  to changed to state 
>>> "active+recovering") . osd.21 still down after following logs:
>>>
>>>
>>> 2014-10-25 10:57:48.415920 osd.21 [WRN] slow request 30.835731 
>>> seconds old, received at 2014-10-25 10:57:17.580013: 
>>> MOSDPGPush(*7.9d8 *102803 [Push
>>> Op(e13589d8/rbd_data.4b843b2ae8944a.0000000000000c00/head//6, 
>>> version: 102798'7794851, data_included: [0~4194304], data_size: 
>>> 4194304, omap_heade
>>> r_size: 0, omap_entries_size: 0, attrset_size: 2, recovery_info: 
>>> ObjectRecoveryInfo(e13589d8/rbd_data.4b843b2ae8944a.0000000000000c00/head//6@102
>>> 798'7794851, copy_subset: [0~4194304], clone_subset: {}), 
>>> after_progress: ObjectRecoveryProgress(!first, 
>>> data_recovered_to:4194304, data_complete
>>> :true, omap_recovered_to:, omap_complete:true), before_progress: 
>>> ObjectRecoveryProgress(first, data_recovered_to:0, 
>>> data_complete:false, omap_rec
>>> overed_to:, omap_complete:false))]) v2 currently no flag points reached
>>>
>>> 2014-10-25 10:57:48.415927 osd.21 [WRN] slow request 30.275588 
>>> seconds old, received at 2014-10-25 10:57:18.140156: 
>>> MOSDPGPush(*23.596* 102803 [Pus
>>> hOp(4ca76d96/rbd_data.5dd32f2ae8944a.0000000000000385/head//24, 
>>> version: 102798'295732, data_included: [0~4194304], data_size: 
>>> 4194304, omap_head
>>> er_size: 0, omap_entries_size: 0, attrset_size: 2, recovery_info: 
>>> ObjectRecoveryInfo(4ca76d96/rbd_data.5dd32f2ae8944a.0000000000000385/head//24@1
>>> 02798'295732, copy_subset: [0~4194304], clone_subset: {}), 
>>> after_progress: ObjectRecoveryProgress(!first, 
>>> data_recovered_to:4194304, data_complet
>>> e:true, omap_recovered_to:, omap_complete:true), before_progress: 
>>> ObjectRecoveryProgress(first, data_recovered_to:0, 
>>> data_complete:false, omap_re
>>> covered_to:, omap_complete:false))]) v2 currently no flag points reached
>>>
>>> 2014-10-25 10:57:48.415910 osd.21 [WRN] slow request 30.860696 
>>> seconds old, received at 2014-10-25 10:57:17.555048: 
>>> MOSDPGPush(*23.9c6* 102803 [Pus
>>> hOp(efdde9c6/rbd_data.5b64062ae8944a.0000000000000b15/head//24, 
>>> version: 102798'66056, data_included: [0~4194304], data_size: 
>>> 4194304, omap_heade
>>> r_size: 0, omap_entries_size: 0, attrset_size: 2, recovery_info: 
>>> ObjectRecoveryInfo(efdde9c6/rbd_data.5b64062ae8944a.0000000000000b15/head//24@10
>>> 2798'66056, copy_subset: [0~4194304], clone_subset: {}), 
>>> after_progress: ObjectRecoveryProgress(!first, 
>>> data_recovered_to:4194304, data_complete:
>>> true, omap_recovered_to:, omap_complete:true), before_progress: 
>>> ObjectRecoveryProgress(first, data_recovered_to:0, 
>>> data_complete:false, omap_reco
>>> vered_to:, omap_complete:false))]) v2 currently no flag points reached
>>>
>>> 2014-10-25 10:57:58.418847 osd.21 [WRN] 26 slow requests, 1 included 
>>> below; oldest blocked for > 54.967456 secs
>>> 2014-10-25 10:57:58.418859 osd.21 [WRN] slow request 30.967294 
>>> seconds old, received at 2014-10-25 10:57:27.451488: 
>>> MOSDPGPush(*23.63c* 102803 [Pus
>>> hOp(40e4b63c/rbd_data.57ed612ae8944a.0000000000000c00/head//24, 
>>> version: 102748'145637, data_included: [0~4194304], data_size: 
>>> 4194304, omap_head
>>> er_size: 0, omap_entries_size: 0, attrset_size: 2, recovery_info: 
>>> ObjectRecoveryInfo(40e4b63c/rbd_data.57ed612ae8944a.0000000000000c00/head//24@1
>>> 02748'145637, copy_subset: [0~4194304], clone_subset: {}), 
>>> after_progress: ObjectRecoveryProgress(!first, 
>>> data_recovered_to:4194304, data_complet
>>> e:true, omap_recovered_to:, omap_complete:true), before_progress: 
>>> ObjectRecoveryProgress(first, data_recovered_to:0, 
>>> data_complete:false, omap_re
>>> covered_to:, omap_complete:false))]) v2 currently no flag points reached
>>>
>>> Thanks!
>>> --
>>> Tuan
>>> HaNoi-VietNam
>>>
>>> On 10/25/2014 05:07 AM, Craig Lewis wrote:
>>>> It looks like you're running into http://tracker.ceph.com/issues/5699
>>>>
>>>> You're running 0.80.7, which has a fix for that bug. From my 
>>>> reading of the code, I believe the fix only prevents the issue from 
>>>> occurring.  It doesn't work around or repair bad snapshots created 
>>>> on older versions of Ceph.
>>>>
>>>> Were any of the snapshots you're removing up created on older 
>>>> versions of Ceph?  If they were all created on Firefly, then you 
>>>> should open a new tracker issue, and try to get some help on IRC or 
>>>> the developers mailing list.
>>>>
>>>> On Thu, Oct 23, 2014 at 10:21 PM, Ta Ba Tuan <tuantb-QlevPasa8l681eZEIcUDRw@public.gmane.org 
>>>> <mailto:tuantb-QlevPasa8l681eZEIcUDRw@public.gmane.org>> wrote:
>>>>
>>>>     Dear everyone
>>>>
>>>>     I can't start osd.21, (attached log file).
>>>>     some pgs can't be repair. I'm using replicate 3 for my data pool.
>>>>     Feel some objects in those pgs be failed,
>>>>
>>>>     I tried to delete some data that related above objects, but
>>>>     still not start osd.21
>>>>     and, removed osd.21, but other osds (eg: osd.86 down, not start
>>>>     osd.86).
>>>>
>>>>     Guide me to debug it, please! Thanks!
>>>>
>>>>     --
>>>>     Tuan
>>>>     Ha Noi - VietNam
>>>>
>>>>
>>>>
>>>>
>>>>
>>>>
>>>>
>>>>
>>>>
>>>>
>>>>     _______________________________________________
>>>>     ceph-users mailing list
>>>>     ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
>>>>     http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>>>>
>>>>
>>>
>>>
>>>
>>> _______________________________________________
>>> ceph-users mailing list
>>> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
>>> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>>
>
>
>
> _______________________________________________
> ceph-users mailing list
> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com


--------------020602070300070406020506
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<html>
  <head>
    <meta content="text/html; charset=ISO-8859-1"
      http-equiv="Content-Type">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <div class="moz-cite-prefix">#ceph pg <b>6.9d8</b> query<br>
      ...<br>
      &nbsp; "peer_info": [<br>
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; { "peer": "49",<br>
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; "pgid": "6.9d8",<br>
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; "last_update": "102889'7801917",<br>
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; "last_complete": "102889'7801917",<br>
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; "log_tail": "102377'7792649",<br>
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; "last_user_version": 7801879,<br>
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; "last_backfill": "MAX",<br>
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; "purged_snaps":
"[1~7,9~44b,455~1f8,64f~63,6b3~3a,6ee~12f,81f~10,830~8,839~69b,ed7~7,edf~4,ee4~6f5,15da~f9,16d4~1f,16f5~7,16fd~4,1705~5<br>
e,1764~7,1771~78,17eb~12,1800~2,1803~d,1812~3,181a~1,181c~a,1827~3b,1863~1,1865~1,1867~1,186b~e,187a~3,1881~1,1884~7,188c~1,188f~3,1894~5,189f~2,<br>
18ab~1,18c6~1,1922~13,193d~1,1940~1,194a~1,1968~5,1975~1,1979~4,197e~4,1984~1,1987~11,199c~1,19a0~1,19a3~9,19ad~3,19b2~1,19b6~27,19de~8]",<br>
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; "history": { "epoch_created": 164,<br>
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; "last_epoch_started": 102888,<br>
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; "last_epoch_clean": 102888,<br>
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; "last_epoch_split": 0<br>
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; "parent_split_bits": 0,<br>
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; "last_scrub": "91654'7460936",<br>
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; "last_scrub_stamp": "2014-10-10 10:36:25.433016",<br>
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; "last_deep_scrub": "81667'5815892",<br>
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; "last_deep_scrub_stamp": "2014-08-29
      09:44:14.012219",<br>
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; "last_clean_scrub_stamp": "2014-10-10
      10:36:25.433016",<br>
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; "log_size": 9229,<br>
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; "ondisk_log_size": 9229,<br>
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; "stats_invalid": "1",<br>
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; "stat_sum": { "num_bytes": 17870536192,<br>
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; "num_objects": 4327,<br>
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; "num_object_clones": 29,<br>
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; "num_object_copies": 12981,<b><br>
      </b><b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; "num_objects_missing_on_primary": 4,</b><br>
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; "num_objects_degraded": 4,<br>
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; "num_objects_unfound": 0,<br>
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; "num_objects_dirty": 1092,<br>
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; "num_whiteouts": 0,<br>
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; "num_read": 4820626,<br>
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; "num_read_kb": 59073045,<br>
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; "num_write": 12748709,<br>
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; "num_write_kb": 181630845,<br>
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; "num_scrub_errors": 0,<br>
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; "num_shallow_scrub_errors": 0,<br>
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; "num_deep_scrub_errors": 0,<br>
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; "num_objects_recovered": 135847,<br>
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; "num_bytes_recovered": 562255538176,<br>
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; "num_keys_recovered": 0,<br>
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; "num_objects_omap": 0,<br>
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; "num_objects_hit_set_archive": 0},<br>
      <br>
      <br>
      On 10/25/2014 07:40 PM, Ta Ba Tuan wrote:<br>
    </div>
    <blockquote cite="mid:544B9A59.4020502-QlevPasa8l681eZEIcUDRw@public.gmane.org" type="cite">
      <meta content="text/html; charset=ISO-8859-1"
        http-equiv="Content-Type">
      <div class="moz-cite-prefix">My Ceph was hung, and&nbsp;&nbsp;&nbsp; "osd.21
        172.30.5.2:6870/8047 879 : [ERR] 6.9d8 has 4 objects unfound and
        apparently lost".<br>
        <br>
        After I restart all ceph-data nodes,&nbsp; I can't start osd.21, have
        many logs about pg 6.9d8 as:<br>
        <br>
        &nbsp;-440&gt; 2014-10-25 19:28:17.468161 7fec5731d700&nbsp; 5 -- op
        tracker -- seq: 3083, time: 2014-10-25 19:28:17.468161, event:
        reached_pg, op: MOSDPGPus<br>
        h(<b>6.9d8</b> 102856 [PushOp(e8de59d8/<b>rbd_data.4d091f7304c844.000000000000e871/head//6</b>,
        version: 102853'7800592, data_included: [0~4194304], data_size:<br>
        &nbsp;4194304, omap_header_size: 0, omap_entries_size: 0,
        attrset_size: 2, recovery_info:
        ObjectRecoveryInfo(e8de59d8/rbd_data.4d091f7304c844.00000000<br>
        0000e871/head//6@102853'7800592, copy_subset: [0~4194304],
        clone_subset: {}), after_progress:
        ObjectRecoveryProgress(!first, data_recovered_to:41<br>
        94304, data_complete:true, omap_recovered_to:,
        omap_complete:true), before_progress:
        ObjectRecoveryProgress(first, data_recovered_to:0, data_comp<br>
        lete:false, omap_recovered_to:, omap_complete:false))])<br>
        <br>
        I think having some error objects. What'm I must do?,please!<br>
        Thanks!<br>
        --<br>
        Tuan<br>
        HaNoi-VietNam<br>
        <br>
        <br>
        On 10/25/2014 03:01 PM, Ta Ba Tuan wrote:<br>
      </div>
      <blockquote cite="mid:544B58D5.6080902-QlevPasa8l681eZEIcUDRw@public.gmane.org" type="cite">
        <meta content="text/html; charset=ISO-8859-1"
          http-equiv="Content-Type">
        <div class="moz-cite-prefix">I send some related bugs:<br>
          (osd.21 not be able started)<br>
          <br>
          &nbsp;-8705&gt; 2014-10-25 14:41:04.345727 7f12bac2f700&nbsp; 5 <b>osd.21</b>
          pg_epoch: 102843 pg[<b>6.5e1</b>( v 102843'11832159
          (102377'11822991,102843'11832159] lb
          c4951de1/rbd_data.3955c5cdbb2ea.00000000000405f0/head//6
          local-les=101780 n=4719 ec=164 les/c 102841/102838
          102840/102840/102477) [40,0,21]/[40,0,60] r=-1 lpr=102840
          pi=31832-102839/230 luod=0'0 crt=102843'11832157 lcod
          102843'11832158 active+remapped] <b>exit
            Started/ReplicaActive/RepNotRecovering</b> 0.000170 1
          0.000296<br>
          <br>
          &nbsp;-1637&gt; 2014-10-25 14:41:14.326580 7f12bac2f700&nbsp; 5 <b>osd.21</b>
          pg_epoch: 102843 pg[<b>2.23b</b>( v 102839'91984
          (91680'88526,102839'91984] local-les=102841 n=85 ec=25000
          les/c 102841/102838 102840/102840/102656) [90,21,120] r=1
          lpr=102840 pi=100114-102839/50 luod=0'0 crt=102839'91984
          active] <b>enter Started/ReplicaActive/RepNotRecovering</b><br>
          <br>
          &nbsp; -437&gt; 2014-10-25 14:41:15.042174 7f12ba42e700&nbsp; 5 <b>osd.21

          </b>pg_epoch: 102843 pg[<b>27.239(</b> v 102808'38419
          (81621'35409,102808'38419] local-les=102841 n=23 ec=25085
          les/c 102841/102838 102840/102840/102656) [90,21,120] r=1
          lpr=102840 pi=100252-102839/53 luod=0'0 crt=102808'38419
          active] <b>enter </b><b>Started/ReplicaActive/RepNotRecovering</b><br>
          <br>
          Thanks!<br>
          <br>
          <br>
          On 10/25/2014 11:26 AM, Ta Ba Tuan wrote:<br>
        </div>
        <blockquote cite="mid:544B2672.6030604-QlevPasa8l681eZEIcUDRw@public.gmane.org" type="cite">
          <meta content="text/html; charset=ISO-8859-1"
            http-equiv="Content-Type">
          <div class="moz-cite-prefix">Hi Craig, Thanks for replying.<br>
            When i started that osd, Ceph Log from "ceph -w" warns pgs
            7.9d8 23.596, 23.9c6, 23.63 can't recovery as pasted log.<br>
            <br>
            Those pgs are "active+degraded" state. <br>
            #ceph pg map 7.9d8 <br>
            osdmap e102808 pg 7.9d8 (7.9d8) -&gt; up [93,49] acting
            [93,49]&nbsp; (When start osd.21 then pg 7.9d8 and three remain
            pgs&nbsp; to changed to state "active+recovering") . osd.21 still
            down after following logs:<br>
            <br>
            <br>
            2014-10-25 10:57:48.415920 osd.21 [WRN] slow request
            30.835731 seconds old, received at 2014-10-25
            10:57:17.580013: MOSDPGPush(<b>7.9d8 </b>102803 [Push<br>
            Op(e13589d8/rbd_data.4b843b2ae8944a.0000000000000c00/head//6,

            version: 102798'7794851, data_included: [0~4194304],
            data_size: 4194304, omap_heade<br>
            r_size: 0, omap_entries_size: 0, attrset_size: 2,
            recovery_info:
ObjectRecoveryInfo(e13589d8/rbd_data.4b843b2ae8944a.0000000000000c00/head//6@102<br>
            798'7794851, copy_subset: [0~4194304], clone_subset: {}),
            after_progress: ObjectRecoveryProgress(!first,
            data_recovered_to:4194304, data_complete<br>
            :true, omap_recovered_to:, omap_complete:true),
            before_progress: ObjectRecoveryProgress(first,
            data_recovered_to:0, data_complete:false, omap_rec<br>
            overed_to:, omap_complete:false))]) v2 currently no flag
            points reached<br>
            <br>
            2014-10-25 10:57:48.415927 osd.21 [WRN] slow request
            30.275588 seconds old, received at 2014-10-25
            10:57:18.140156: MOSDPGPush(<b>23.596</b> 102803 [Pus<br>
            hOp(4ca76d96/rbd_data.5dd32f2ae8944a.0000000000000385/head//24,


            version: 102798'295732, data_included: [0~4194304],
            data_size: 4194304, omap_head<br>
            er_size: 0, omap_entries_size: 0, attrset_size: 2,
            recovery_info:
ObjectRecoveryInfo(4ca76d96/rbd_data.5dd32f2ae8944a.0000000000000385/head//24@1<br>
            02798'295732, copy_subset: [0~4194304], clone_subset: {}),
            after_progress: ObjectRecoveryProgress(!first,
            data_recovered_to:4194304, data_complet<br>
            e:true, omap_recovered_to:, omap_complete:true),
            before_progress: ObjectRecoveryProgress(first,
            data_recovered_to:0, data_complete:false, omap_re<br>
            covered_to:, omap_complete:false))]) v2 currently no flag
            points reached<br>
            <br>
            2014-10-25 10:57:48.415910 osd.21 [WRN] slow request
            30.860696 seconds old, received at 2014-10-25
            10:57:17.555048: MOSDPGPush(<b>23.9c6</b> 102803 [Pus<br>
            hOp(efdde9c6/rbd_data.5b64062ae8944a.0000000000000b15/head//24,


            version: 102798'66056, data_included: [0~4194304],
            data_size: 4194304, omap_heade<br>
            r_size: 0, omap_entries_size: 0, attrset_size: 2,
            recovery_info:
ObjectRecoveryInfo(efdde9c6/rbd_data.5b64062ae8944a.0000000000000b15/head//24@10<br>
            2798'66056, copy_subset: [0~4194304], clone_subset: {}),
            after_progress: ObjectRecoveryProgress(!first,
            data_recovered_to:4194304, data_complete:<br>
            true, omap_recovered_to:, omap_complete:true),
            before_progress: ObjectRecoveryProgress(first,
            data_recovered_to:0, data_complete:false, omap_reco<br>
            vered_to:, omap_complete:false))]) v2 currently no flag
            points reached<br>
            <br>
            2014-10-25 10:57:58.418847 osd.21 [WRN] 26 slow requests, 1
            included below; oldest blocked for &gt; 54.967456 secs<br>
            2014-10-25 10:57:58.418859 osd.21 [WRN] slow request
            30.967294 seconds old, received at 2014-10-25
            10:57:27.451488: MOSDPGPush(<b>23.63c</b> 102803 [Pus<br>
            hOp(40e4b63c/rbd_data.57ed612ae8944a.0000000000000c00/head//24,


            version: 102748'145637, data_included: [0~4194304],
            data_size: 4194304, omap_head<br>
            er_size: 0, omap_entries_size: 0, attrset_size: 2,
            recovery_info:
ObjectRecoveryInfo(40e4b63c/rbd_data.57ed612ae8944a.0000000000000c00/head//24@1<br>
            02748'145637, copy_subset: [0~4194304], clone_subset: {}),
            after_progress: ObjectRecoveryProgress(!first,
            data_recovered_to:4194304, data_complet<br>
            e:true, omap_recovered_to:, omap_complete:true),
            before_progress: ObjectRecoveryProgress(first,
            data_recovered_to:0, data_complete:false, omap_re<br>
            covered_to:, omap_complete:false))]) v2 currently no flag
            points reached<br>
            <br>
            Thanks!<br>
            --<br>
            Tuan<br>
            HaNoi-VietNam<br>
            <br>
            On 10/25/2014 05:07 AM, Craig Lewis wrote:<br>
          </div>
          <blockquote
cite="mid:CADHZLBaU6LrQN+Y7JKfx9LLaHBmVZKVccNb90Z17nZZrjiharg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org"
            type="cite">
            <div dir="ltr">It looks like you're running into&nbsp;<a
                moz-do-not-send="true"
                href="http://tracker.ceph.com/issues/5699">http://tracker.ceph.com/issues/5699</a>
              <div><br>
              </div>
              <div>You're running 0.80.7, which has a fix for that bug.&nbsp;
                From my reading of the code, I believe the fix only
                prevents the issue from occurring.&nbsp; It doesn't work
                around or repair bad snapshots created on older versions
                of Ceph.</div>
              <div><br>
              </div>
              <div>Were any of the snapshots you're removing up created
                on older versions of Ceph?&nbsp; If they were all created on
                Firefly, then you should open a new tracker issue, and
                try to get some help on IRC or the developers mailing
                list.</div>
              <div>&nbsp;</div>
            </div>
            <div class="gmail_extra"><br>
              <div class="gmail_quote">On Thu, Oct 23, 2014 at 10:21 PM,
                Ta Ba Tuan <span dir="ltr">&lt;<a
                    moz-do-not-send="true"
                    href="mailto:tuantb-QlevPasa8l681eZEIcUDRw@public.gmane.org" target="_blank">tuantb-QlevPasa8l681eZEIcUDRw@public.gmane.org</a>&gt;</span>
                wrote:<br>
                <blockquote class="gmail_quote" style="margin:0 0 0
                  .8ex;border-left:1px #ccc solid;padding-left:1ex">Dear
                  everyone<br>
                  <br>
                  I can't start osd.21, (attached log file).<br>
                  some pgs can't be repair. I'm using replicate 3 for my
                  data pool.<br>
                  Feel some objects in those pgs be failed,<br>
                  <br>
                  I tried to delete some data that related above
                  objects, but still not start osd.21<br>
                  and, removed osd.21, but other osds (eg: osd.86 down,
                  not start osd.86).<br>
                  <br>
                  Guide me to debug it, please! Thanks!<br>
                  <br>
                  --<br>
                  Tuan<br>
                  Ha Noi - VietNam<br>
                  <br>
                  <br>
                  <br>
                  <br>
                  <br>
                  <br>
                  <br>
                  <br>
                  <br>
                  <br>
                  _______________________________________________<br>
                  ceph-users mailing list<br>
                  <a moz-do-not-send="true"
                    href="mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org">ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org</a><br>
                  <a moz-do-not-send="true"
                    href="http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com"
                    target="_blank">http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com</a><br>
                  <br>
                </blockquote>
              </div>
              <br>
            </div>
          </blockquote>
          <br>
          <br>
          <fieldset class="mimeAttachmentHeader"></fieldset>
          <br>
          <pre wrap="">_______________________________________________
ceph-users mailing list
<a moz-do-not-send="true" class="moz-txt-link-abbreviated" href="mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org">ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org</a>
<a moz-do-not-send="true" class="moz-txt-link-freetext" href="http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com">http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com</a>
</pre>
        </blockquote>
        <br>
      </blockquote>
      <br>
      <br>
      <fieldset class="mimeAttachmentHeader"></fieldset>
      <br>
      <pre wrap="">_______________________________________________
ceph-users mailing list
<a class="moz-txt-link-abbreviated" href="mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org">ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org</a>
<a class="moz-txt-link-freetext" href="http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com">http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com</a>
</pre>
    </blockquote>
    <br>
  </body>
</html>

--------------020602070300070406020506--

--===============0541794296==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============0541794296==--
