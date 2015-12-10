From: Jan Schermer <jan-SB6/BxVxTjHtwjQa/ONI9g@public.gmane.org>
Subject: Re: Client io blocked when removing snapshot
Date: Thu, 10 Dec 2015 15:21:32 +0100
Message-ID: <4873E4A6-9470-472C-B2FB-630C944242CD@schermer.cz>
References: <47D132BF400BE64BAE6D71033F7D3D7503DE0DF4@H3CMLB12-EX.srv.huawei-3com.com>
	<34168A89-37E0-4FCE-96EC-EBA0EC6CA904@schermer.cz>
	<alpine.DEB.2.00.1512100613120.19170@cobra.newdream.net>
Mime-Version: 1.0 (Mac OS X Mail 9.2 \(3112\))
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <alpine.DEB.2.00.1512100613120.19170-vIokxiIdD2AQNTJnQDzGJqxOck334EZe@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Sage Weil <sage-BnTBU8nroG7k1uMJSBkQmQ@public.gmane.org>
Cc: "&RD-STOR-FIRE-vVzyEvZLFYE@public.gmane.org" <&RD-STOR-FIRE-vVzyEvZLFYE@public.gmane.org>, "ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, Wukongming <wu.kongming-vVzyEvZLFYE@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org


> On 10 Dec 2015, at 15:14, Sage Weil <sage-BnTBU8nroG7k1uMJSBkQmQ@public.gmane.org> wrote:
> 
> On Thu, 10 Dec 2015, Jan Schermer wrote:
>> Removing snapshot means looking for every *potential* object the snapshot can have, and this takes a very long time (6TB snapshot will consist of 1.5M objects (in one replica) assuming the default 4MB object size). The same applies to large thin volumes (don't try creating and then dropping a 1 EiB volume, even if you only have 1GB of physical space :)).
>> Doing this is simply expensive and might saturate your OSDs. If you don't have enough RAM to cache the structure then all the "is there a file /var/lib/ceph/...." will go to disk and that can hurt a lot.
>> I don't think there's any priority to this (is there?), so it competes with everything else.
>> 
>> I'm not sure how snapshots are exactly coded in Ceph, but in a COW filesystem you simply don't dereference blocks of the parent of the  snapshot when doing writes to it and that's cheap, but Ceph stores "blocks" in files with computable names and has no pointers to them that could be modified,  so by creating a snapshot you hurt the performance a lot (you need to create a copy of the 4MB object into the snapshot(s) when you dirty a byte in there). Though I remember reading that the logic is actually reversed and it is the snapshot that gets the original blocks(??)...
>> Anyway if you are removing snapshot at the same time as writing to the parent there could be potentionaly a problem in what gets done first. Is Ceph smart enough to not care about snapshots that are getting deleted? I have no idea but I think it must be because we use snapshots a lot and haven't had that any issues with it.
> 
> It's not quite so bad... the OSD maintains a map (in leveldb) of the 
> objects that are referenced by a snapshot, so the amount of work is 
> proportional to the number of objects that were cloned for that snapshot.
> 


Nice. I saw a blueprint somewhere earlier this year, so that's a pretty new thing (Hammer or Infernalis?)
And is it a map (with pointers to objects) or just a bitmap of the overlay?

Jan

> There is certainly room for improvement in terms of the impact on client 
> IO, though.  :)
> 
> sage
