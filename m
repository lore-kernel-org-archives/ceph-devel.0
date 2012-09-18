From: John Axel Eriksson <john@insane.se>
Subject: Re: How are you using Ceph?
Date: Tue, 18 Sep 2012 19:09:41 +0200
Message-ID: <CAMmJxtJtfCg6J74KWq4M=3=bWPYASnU++8MZrSgx1Puu-SxNhA@mail.gmail.com>
References: <CAHb+bZ+x3NxLBYWb-dt8CD4x4Zzud9Cqp90ug-vS=hC-O-f4wg@mail.gmail.com>
	<5057543902000099000EA573@collaborate.seakr.com>
	<5057A9E9.8060108@inktank.com>
	<CAMmJxtJERSc822Uy=_zsh2_D+_V9dnpzyQoSqDrSrJ3W_J7o8w@mail.gmail.com>
	<20120918094702.43a63480@dieter-t420s>
	<CAMmJxtJP5WVDcE89sPQYKnkpM75dCnAY7fEdxAzRyFtUxG=9ig@mail.gmail.com>
	<50589F66.1060109@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vc0-f174.google.com ([209.85.220.174]:44013 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751713Ab2IRRJm (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 18 Sep 2012 13:09:42 -0400
Received: by vcbfo13 with SMTP id fo13so104041vcb.19
        for <ceph-devel@vger.kernel.org>; Tue, 18 Sep 2012 10:09:41 -0700 (PDT)
In-Reply-To: <50589F66.1060109@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Xiaopong Tran <xiaopong.tran@gmail.com>
Cc: "Plaetinck, Dieter" <dieter@vimeo.com>, ceph-devel@vger.kernel.org

Hey Xiaopong (is that your first or last name by the way? - sorry for
my ignorance),

I feel your pain believe me :-). We've had many sleepless nights
salvaging data. We've actually completely
migrated off Riak/Luwak by now and are pretty happy about it. As you
say - we've watched the cluster go down
in flames too many times to count, especially migrating all the data
to Ceph has been a bit of a pain(not because of Ceph).
And yes, really large files can make the cluster go insane - I think
because there might be a missing piece somewhere.

If you didn't know about it (we didn't) - if you want/need to do a
read-repair on the keys in Luwak(which might solve your problems)
you have to go about it in a special way. Normally in "standard" riak
k/v you would simply list all your keys and http GET them, not
so in Luwak. It is however possible to do a read-repair of Luwak but
you must connect to a different endpoint, so:

If you've got luwak at the default location, eg:

http://some-riak-host:8098/luwak

you would need to list the actual keys(the pieces of the key in Luwak)
like this:

curl http://some-riak-host:8098/riak/luwak_node?keys=true (or perhaps
keys=stream)
note above that it's not /luwak but /riak/luwak_node

Then you would have to loop through all those keys and http GET them like so:

curl http://some-riak-host:8098/riak/luwak_node/<thekey>

These keys will look something like
"9c6f84432c1a164a2fdcda917e6b06f1812f4078fb9bff9fc065ef8b70ae7df21184c014c124842a8aab733f572166ef5c6cef69c5dc4e1e73515ceadc82af99"

What you get from the key stream is actually json(you probably knew
that though) so you will also need to massage that data to get a clean
simple text file with one key each line. A suggestion
is also to loop through maybe 10 000 keys at a time, then sleep for a
few minutes(maybe at least 10 mins) so the cluster has time to
actually repair and gossip about only those 10 000 keys. Don't
want it to eat all your memory ;-).

Needless to say, depending on the amount of data in your cluster the
repair process (eg. http GETing all the keys) will take alot of time.
We had it running for several days.

Hope this helps and good luck with the migration!

-John

On Tue, Sep 18, 2012 at 6:20 PM, Xiaopong Tran <xiaopong.tran@gmail.com> wrote:
> Excellent write-up. We are exactly in the same mess with
> Riak Luwak, a decision that was made before I took over the
> project. I thought we were the only one :)
>
> We are still paying the price for it, as after over
> a month of migrating the data from Riak to Ceph, we barely
> moved 30% of the data.
>
> When we retrieve a large file from Riak, it sometimes goes
> crazy and can bring down the whole cluster of 10 nodes.
> We keep on adding memory, and this thing does not seem
> to have enough of it. And after one day of usage, it would
> slow to a crawl, and we ended up recycling the cluster once
> a day (sometimes more).
>
> And as you have said, deleting just doesn't work. And a lots
> of other issues too.
>
> Then we were proposed the Riak CS. It all looks
> great on paper, however, with the experiences of
> Riak Luwak, which also looked great on paper, we
> wouldn't even dare to consider.
>
> I can't wait until the day we get rid off of it totally.
>
> Best,
>
> Xiaopong
>
>
>
> On 09/18/2012 10:34 PM, John Axel Eriksson wrote:
>>
>> I actually opted to not specifically mention the product we had
>> problems with since there have been lots of changes and fixes to it,
>> which we unfortunately were unable to make use of(you'll know why
>> later). But I guess it's interesting enough to go into a little more
>> detail so... before moving to Ceph we were using the Riak Distributed
>> Database from Basho - http://riak.basho.com.
>>
>> First I have to say that Riak is actually pretty awesome in many ways
>> - not in the least operations wise. Compared to Ceph it's alot easier
>> to get up and running and add storage as you go... basically just one
>> command to add a node to the cluster and you only need the address of
>> any other existing node for this. With Riak, every node is the same,
>> so there is no SPOF by default (eg. no MDS, no MON - just nodes).
>>
>> As you might have thought already "Distributed Database isn't exactly
>> the same as Distributed Storage" so why did we use it? Well, there is
>> an add-on to Riak called Luwak, also created and supported by Basho,
>> that is touted as "Large Object Support" where you can store as large
>> objects as you want. I think our main problem was with using this
>> add-on (as I said created and supported by Basho). An object in
>> "standard" riak k/v is limited to... I think around 40 MB, or at least
>> you shouldn't store larger objects than that because it means
>> "trouble". Anyway, we went with Luwak which seemed to be a perfect
>> solution for the type of storage we do.
>>
>> We ran with Luwak for almost two years and usually it served us pretty
>> well. Unfortunately there were bugs and hidden problems which i.m.o
>> Basho should have been more open about. One issue is that Riak is
>> based on a repair mechanism called "read-repair" - that pretty much
>> tells you how it works, data will only be repaired on a read. Now that
>> is a problem in itself when you archive data which we do (eg. not
>> reading it very often or at all).
>>
>> With Luwak(the large-object add-on), data is split into many keys and
>> values and stored in the "normal" riak k/v store... unfortunately
>> read-repair in this scenario doesn't seem to work at all and if
>> something was missing - Riak had a tendency to crash HARD, sometimes
>> managing to take the whole machine with it. There were also strange
>> issues where one crashing node seemed to affect it's neighbors so that
>> they also crashed... a domino effect which makes "distributed" a
>> little too "distributed". This didn't always happen but it did happen
>> several times in our case. The logs were often pretty hard to
>> understand and more often than not left us completely in the dark
>> about what was going on.
>>
>> We also discovered that deleting data in Luwak doesn't actually DO
>> anything... sure the key is gone but data is still on disk - seemingly
>> orphaned, so deleting was more or less a noop. This was nowhere to be
>> found in the docs.
>>
>> Finally, I think 3rd of June this year, we requested paid support from
>> Basho to help us in our last crash-and-burn situation and that's when
>> we, among other things, were told about the fact that DELETEing just
>> seems to work. We were also told that Luwak was originally created to
>> store email and not really the types of things we store (eg. files).
>> This information wasn't available anywhere - Luwak simply had the
>> wrong "table of contents" associated with it. All this was quite a
>> turn-off for us. To Bashos credit they really did help us fix our
>> cluster and they're really nice, friendly and helpful guys.
>>
>> Actually I think the last straw was when Luwak was suddenly - out of
>> nowhere really - discontinued around the beginning of this year,
>> probably because of the bugs and hidden problems that I think may have
>> come from a less than stellar implementation of large-object support
>> from the start... so by then we were on something completely
>> unsupported. We couldn't switch to something else immediately of
>> course but we started looking around for something else at that time.
>> That's when I found Ceph among other more or less distributed systems,
>> where the others were:
>>
>> Tahoe-LAFS       https://tahoe-lafs.org/trac/tahoe-lafs
>> XtreemFS         http://www.xtreemfs.org
>> HDFS             http://hadoop.apache.org/hdfs/
>> GlusterFS        http://www.gluster.org
>> PomegranateFS    https://github.com/macan/Pomegranate/wiki
>> moosefs          http://www.moosefs.org
>> Openstack Swift  http://docs.openstack.org/developer/swift/
>> MongoDB GridFS   http://www.mongodb.org/display/DOCS/GridFS
>> LS4              http://ls4.sourceforge.net/
>>
>> After trying most of these I decided to look closer at a few of them,
>> MooseFS, HDFS, XtreemFS and Ceph - the others were either not really
>> suited for our use case or just too complicated to setup and keep
>> running (i.m.o). For a short while I dabbled in writing my own storage
>> system using zeromq for communication but it's just not what our
>> company does - so I gave that up pretty quickly :-). In the end I
>> chose Ceph. Ceph wasn't as easy as Riak/Luwak operationally but in
>> every other aspect better and definitely a good fit. The Rados
>> Gateway(S3 compat) was really a big thing for us as well.
>>
>> As I started out saying: there have been many improvements to Riak not
>> in the least to the large-object support... but that large-object
>> support is not built on Luwak but a completely new thing and it's not
>> open source or free. It's called Riak CS(CS for Cluster Storage I
>> guess) and has an S3 compatible interface and it seems to be pretty
>> good. We had many discussions internally if Riak CS was the right move
>> for us but in the end we decided on Ceph since we couldn't justify the
>> cost of Riak CS.
>>
>> To sum it up: we made, in retrospect, a bad choice - not because Riak
>> itself doesn't work or isn't any good for the things it's good at(it
>> really is!) but because the add-on Luwak was misrepresented and not a
>> good fit for us.
>>
>> I really have high hopes for Ceph and I think it has a bright future
>> in our company and in general. Riak CS would probably have been a very
>> good fit as well if it wasn't for the cost involved.
>>
>> So there you have it - not just failure scenarios but bad decisions,
>> misrepresenation of features and somewhat sparse documentation. By the
>> the way, Ceph has improved it's docs alot but still could use some
>> work.
>>
>> -John
>>
>>
>> On Tue, Sep 18, 2012 at 9:47 AM, Plaetinck, Dieter<dieter@vimeo.com>
>> wrote:
>>>
>>> On Tue, 18 Sep 2012 01:26:03 +0200
>>> John Axel Eriksson<john@insane.se>  wrote:
>>>
>>>> another distributed
>>>> storage solution that had failed us more than once and we lost data.
>>>> Since the old system had an http interface (not S3 compatible though)
>>>
>>>
>>> can you say a bit more about this? failure stories are very interesting
>>> and useful.
>>>
>>> Dieter
>>
>> --
>>
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
