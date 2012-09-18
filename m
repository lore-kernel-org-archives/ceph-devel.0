From: Ian Pye <ianpye@gmail.com>
Subject: Re: How are you using Ceph?
Date: Mon, 17 Sep 2012 22:44:05 -0700
Message-ID: <CAEVWPAV0gRmnz5beVtqcOqx49ipjyf0ncX+hd5yR06zQjzV-NA@mail.gmail.com>
References: <1784724793.100.1347938272315.JavaMail.root@thunderbeast.private.linuxbox.com>
	<2054194652.102.1347938381504.JavaMail.root@thunderbeast.private.linuxbox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:32776 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755270Ab2IRFoH convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 18 Sep 2012 01:44:07 -0400
Received: by lbbgj3 with SMTP id gj3so4726801lbb.19
        for <ceph-devel@vger.kernel.org>; Mon, 17 Sep 2012 22:44:05 -0700 (PDT)
In-Reply-To: <2054194652.102.1347938381504.JavaMail.root@thunderbeast.private.linuxbox.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

I'm looking at building a hbase/bigtable style key-value store on top
of Ceph's omap abstraction of LevelDB. The plan is to use this for log
storage at first. Writes use libradospp, with individual log lines
serialized via message-pack and then stored as omap values.  Omap keys
are strings which group common data together using a similar prefix.

Reads are exposed using a custom fuse integration which supports query
parameters separated via the # token like so:

cat /cf/adefs/logger/pg/data/2012-08-28/OID/2/1346191920#pr=N:1015438#lm=1#fr=json

[{"bcktime":"0.000","bcktype":"BCK_C1","bytes_bck":"2196","bytes_dlv":"2196","cachestat":"HIT","chktime":"0.000","chktimestamp":"1346192219","country":"CA","dc_old":"IMAGE","dlvtime":"0.002","doctype":"IMAGE","domuid":"df475bc52ab9f7b546ef60a8e2803bca61343075938","dw_key":"N:1015438:208.69.:IMAGE:14f1-1343075940.119-10-115680413","host":"www.forum.immigrer.com","hoststat":"200","http_method":"GET","http_proto":"HTTP/1.1","id":"14f1-1343075940.119-10-115680413","iptype":"CLEAN","ownerid":"226010","path_op":"WL","path_src":"MACRO","path_stat":"NR","rmoteip":"208.69.11.150","seclvl":"eoff","servnmdlv":"14f1","servnmflc":"14f1","uag":"Mozilla/5.0
(Windows NT 6.1; rv:14.0) Gecko/20100101
Firefox/14.0.1","url":"/icon-16.png","zone_plan":"pro","zoneid":"1015438","zonename":"immigrer.com"},{"bytes_bck":2196,"bytes_dlv":2196,"cfbb":0,"flstat":470,"hoststat":200,"isbot":0,"missing_dlv":0,"ownerid":226010,"s404":0,"upstat":0,"zoneid":1015438}]

Passing in a pr parameter downloads only those keys matching the
prefix specified. fr is a format (json or msgpack) and lm is a limit.

I'm also working with the CLS framework to compute aggregate values
(for example the average request size) on the OSDs directly.

A further level of abstraction is provided by writing a postgres to
ceph binding, exposing omap values as postgres hstores. This allows
Postgres functions like:

select kc_hstore->'uag' as user_agent, count(*) as cn from
kc_hstore('1346191920', '2012-08-28/OID/1', 'N:') group by user_agent
order by cn desc limit 10;

                                                      user_agent
                                                |  cn
-----------------------------------------------------------------------------------------------------------------------+------
 Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/536.11 (KHTML, like
Gecko) Chrome/20.0.1132.57 Safari/536.11          | 1717
 Mozilla/5.0 (Windows NT 6.1; WOW64; rv:14.0) Gecko/20100101
Firefox/14.0.1                                            |  862
 Mozilla/5.0 (compatible; MSIE 9.0; Windows NT 6.1; WOW64;
Trident/5.0)                                                |  837
 Mozilla/5.0 (Windows NT 6.1) AppleWebKit/536.11 (KHTML, like Gecko)
Chrome/20.0.1132.57 Safari/536.11                 |  504
 Mozilla/5.0 (Windows NT 5.1) AppleWebKit/536.11 (KHTML, like Gecko)
Chrome/20.0.1132.57 Safari/536.11                 |  332
 Mozilla/5.0 (Windows NT 6.1; WOW64; rv:13.0) Gecko/20100101
Firefox/13.0.1                                            |  312
 Mozilla/5.0 (Windows NT 6.0) AppleWebKit/536.11 (KHTML, like Gecko)
Chrome/20.0.1132.57 Safari/536.11                 |  256
 Mozilla/5.0 (compatible; MSIE 9.0; Windows NT 6.1; Trident/5.0)
                                                |  220
 Mozilla/5.0 (Windows NT 6.1; rv:14.0) Gecko/20100101 Firefox/14.0.1
                                                |  178
 Mozilla/5.0 (Macintosh; Intel Mac OS X 10_6_8) AppleWebKit/534.57.2
(KHTML, like Gecko) Version/5.1.7 Safari/534.57.2 |  172
(10 rows)

Here, we get the top 10 most common user agents seen for a given time
range and data shard.

Currently using xfs, as I too have been bitten by btrfs.



On Mon, Sep 17, 2012 at 8:19 PM, Matt W. Benjamin <matt@linuxbox.com> wrote:
> Hi
>
> Just FYI, on the NFS integration front.  A pnfs files (RFC5661)-capable NFSv4 re-exporter for Ceph has been committed to the Ganesha NFSv4 server development branch.  We're continuing to enhance and elaborate this.  We have had on our (full) plates for a while to return Ceph client library changes.  We've finished pullup and rebasing of these, are doing some final testing of a couple things in preparation to push a branch for review.
>
> Regards,
>
> Matt
>
> ----- "Sage Weil" <sage@inktank.com> wrote:
>
>> On Mon, 17 Sep 2012, Tren Blackburn wrote:
>> > On Mon, Sep 17, 2012 at 5:05 PM, Smart Weblications GmbH - Florian
>> > Wiessner <f.wiessner@smart-weblications.de> wrote:
>> > >
>> > > Hi,
>> > >
>> > > i use ceph to provide storage via rbd for our virtualization
>> cluster delivering
>> > > KVM based high availability Virtual Machines to my customers. I
>> also use it
>> > > as rbd device with ocfs2 on top of it for a 4 node webserver
>> cluster as shared
>> > > storage - i do this, because unfortunatelly cephfs is not ready
>> yet ;)
>> > >
>> > Hi Florian;
>> >
>> > When you say "cephfs is not ready yet", what parts about it are not
>> > ready? There are vague rumblings about that in general, but I'd
>> love
>> > to see specific issues. I understand multiple *active* mds's are
>> not
>> > supported, but what other issues are you aware of?
>>
>> Inktank is not yet supporting it because we do not have the QA in
>> place
>> and general hardening that will make us feel comfortable recommending
>> it
>> for customers.  That said, it works pretty well for most workloads.
>> In
>> particular, if you stay away from the snapshots and multi-mds, you
>> should
>> be quite stable.
>>
>> The engineering team here is about to do a bit of a pivot and refocus
>> on
>> the file system now that the object store and RBD are in pretty good
>> shape.  That will mean both core fs/mds stability and features as well
>> as
>> integration efforts (NFS/CIFS/Hadoop).
>>
>> 'Ready' is in the eye of the beholder.  There are a few people using
>> the
>> fs successfully in production, but not too many.
>>
>> sage
>>
>>
>>  >
>> > And if there's a page documenting this already, I apologize...and
>> > would appreciate a link :)
>> >
>> > t.
>> > --
>> > To unsubscribe from this list: send the line "unsubscribe
>> ceph-devel" in
>> > the body of a message to majordomo@vger.kernel.org
>> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> >
>> >
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel"
>> in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
> --
> Matt Benjamin
> The Linux Box
> 206 South Fifth Ave. Suite 150
> Ann Arbor, MI  48104
>
> http://linuxbox.com
>
> tel. 734-761-4689
> fax. 734-769-8938
> cel. 734-216-5309
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
