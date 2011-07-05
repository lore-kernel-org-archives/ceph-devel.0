From: Vasilakakos Giorgos <sugoruyo@gmail.com>
Subject: Re: Question: How does Ceph go from filename to object?
Date: Tue, 5 Jul 2011 21:58:36 +0300
Message-ID: <CANJmCG+5HQfO2Z2bPVGDksrhSo1WryRwZq1fuf3a6aYuB9afrQ@mail.gmail.com>
References: <CANJmCGLt2hPjETaa5bGt71Ewyo4Z-q6XXYsegRUAZNZb-h7J3A@mail.gmail.com>
 <CANJmCG+HZWWnEmpJ+pY4fjweBckRMPh+b6OiD=kk1egwT9B3=Q@mail.gmail.com> <CAF3hT9BNouh83fQiJ4qMHRX6H7bbJ5sd879SE9-Dd2BwWUontA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qy0-f181.google.com ([209.85.216.181]:45074 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751124Ab1GES7R (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 5 Jul 2011 14:59:17 -0400
Received: by qyk9 with SMTP id 9so3631998qyk.19
        for <ceph-devel@vger.kernel.org>; Tue, 05 Jul 2011 11:59:16 -0700 (PDT)
In-Reply-To: <CAF3hT9BNouh83fQiJ4qMHRX6H7bbJ5sd879SE9-Dd2BwWUontA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gregory.farnum@dreamhost.com>
Cc: ceph-devel@vger.kernel.org

OK thanks, I think you've answered my question between this message
and the links you provided.

On Tue, Jul 5, 2011 at 18:29, Gregory Farnum
<gregory.farnum@dreamhost.com> wrote:
> On Mon, Jul 4, 2011 at 10:17 AM, Vasilakakos Giorgos <sugoruyo@gmail.com> wrote:
>> Hello folks, I have a question:
>> I know files get mapped to objects and those objects to OSDs but how
>> exactly do we go from one to the other?
>> What I mean is, given the filename I want to access how does Ceph find
>> the relevant objects? What exactly does CRUSH do?
> The mapping between files and objects is by inode number and doesn't
> involve the filename at all (if it did you'd have to move objects just
> because you'd renamed a file!).
>> Supposedly, the client first asks the MDS for an inode number, what then?
>> How are the object and PG IDs constructed and where exactly does CRUSH come in?
>> My impression is that the OID is made from the name, inode and
>> probably some kind of information about the striping of the file,
>> what about the mapping of an object to a PG?
>> Are PGs mapped to OSDs by means of CRUSH, or are objects mapped to PGs
>> by CRUSH? How are PGs assigned to OSDs then?
> The object name is just the inode number postfixed by a sequence
> counter for each object included in the file. (If it included the file
> name, you'd have to rename objects and move them just because you
> renamed the file. Not good.) The information about striping is
> contained in object metadata that the OSDs keep.
> I believe that by default the striping is just linear, so if your
> object is less than 4MB it will take one object; if it is more than
> 4MB it will take (ceiling(size/4MB)) objects named 2000000001.0,
> 2000000001.1, 2000000001.2....
> You could set up other striping strategies though, so that it striped
> eg 1MB over each object and did 4 stripes per object, but the objects
> would still be named the same.
> CRUSH then maps the OID onto a PG and maps the PG onto an OSD. (So,
> objects are mapped by CRUSH into PGs, and PGs are mapped by CRUSH onto
> OSDs.)
> -Greg
>
