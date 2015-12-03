From: "James (Fei) Liu-SSI" <james.liu@ssi.samsung.com>
Subject: RE: queue_transaction interface + unique_ptr + performance
Date: Thu, 3 Dec 2015 03:50:13 +0000
Message-ID: <99767EA2E27DD44DB4E9F9B9ACA458C05619AA91@SSIEXCH-MB3.ssi.samsung.com>
References: <CO1PR02MB2082647268152AF8A71E84FF40D0@CO1PR02MB208.namprd02.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.ssi.samsung.com ([207.140.43.206]:56965 "EHLO
	mx2.ssi.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755111AbbLCDuR convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 2 Dec 2015 22:50:17 -0500
In-Reply-To: <CO1PR02MB2082647268152AF8A71E84FF40D0@CO1PR02MB208.namprd02.prod.outlook.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Somnath Roy <Somnath.Roy@sandisk.com>, "Sage Weil (sage@newdream.net)" <sage@newdream.net>, "Samuel Just (sam.just@inktank.com)" <sam.just@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi Somnath,
  Great findings. As you mentioned, unique_ptr and smart_ptr always have a well known problem about the performance comparing to conventional pointer , Got a chance to run your interesting code and close to what you find.
But I did not find any place in filestore/newstore (keyvaluestore and journal use them somewhere but not too heavily ) using smart pointer. Am I missing anything?

Thanks,
James

  ##### Test conventional ptr ######
start: %d secs, %d usecs
1449112986729634end: 1449113038 secs, 235140 usecs
micros_used for conventional ptr: 51505506
##### Test Unique Smart ptr ######
start: 1449113038 secs, 235186 usecs
end: 1449113158 secs, 825106 usecs
micros_used for unique ptr: 120589920
##### Test Shared Smart ptr ######
start: 1449113158 secs, 825130 usecs
end: 1449113322 secs, 132210 usecs
micros_used for shared ptr: 163307080
Existing..




-----Original Message-----
From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-owner@vger.kernel.org] On Behalf Of Somnath Roy
Sent: Wednesday, December 02, 2015 6:13 PM
To: Somnath Roy; Sage Weil (sage@newdream.net); Samuel Just (sam.just@inktank.com)
Cc: ceph-devel@vger.kernel.org
Subject: RE: queue_transaction interface + unique_ptr + performance

*Also*, in this way we are unnecessary adding another smart pointer overhead in the Ceph IO path.
As I communicated sometimes back (probably 2 years now :-) ) in the community, profiler is showing these smart pointers (shared_ptr) as one of the hot spot. Now, I decided to actually measure this..Here is my findings from a sample application and using jemalloc.

1.  First, I measured the performance difference of just creation and deletion of various pointers..Here is the result..

##### Test conventional ptr ######
start: 1449107326 secs, 903873 usecs
end: 1449107353 secs, 578709 usecs
micros_used for conventional ptr: 26674836

##### Test Unique Smart ptr ######
start: 1449107353 secs, 578764 usecs
end: 1449107438 secs, 835114 usecs
micros_used for unique ptr: 85256350

##### Test Shared Smart ptr ######
start: 1449107438 secs, 835155 usecs
end: 1449107543 secs, 285443 usecs
micros_used for shared ptr: 104450288

So, as you can see >3x degradation with unique_ptr and ~4x degradation with shared_ptr.
My sample application is single threaded and I can see from perf top lot of other smart_ptr related functions are popping up reducing the actual % of jemalloc cpu usage (thus causing a slowdown).


2. Next, I added pointer dereferencing in the code..Here is the result..

##### Test conventional ptr ######
start: 1449107850 secs, 500595 usecs
end: 1449107876 secs, 936586 usecs
micros_used for conventional ptr: 26435991 ##### Test Unique Smart ptr ######
start: 1449107876 secs, 936643 usecs
end: 1449107994 secs, 629418 usecs
micros_used for unique ptr: 117692775
##### Test Shared Smart ptr ######
start: 1449107994 secs, 629459 usecs
end: 1449108107 secs, 846052 usecs
micros_used for shared ptr: 113216593

This is interesting , not much change in case of conventional pointers but huge change for unique_ptr and some change for shared_ptr as well..So, now degradation for unique_ptr > 4X..This is probably inline with this http://stackoverflow.com/questions/8138284/about-unique-ptr-performances

3. I didn't measure the other stuff like std::move() , reference count in case of shared object etc. This will degrade the performance even more.

4. Here is the sample code in case anybody interested.

#include <iostream>
#include <memory>
#include <list>
#include <sys/time.h>
#include <stdint.h>

struct Foo { // object to manage
    Foo():xx(99),yy(999999) { /*std::cout << "Foo ctor\n";*/ }
    ~Foo() { /*std::cout << "~Foo dtor\n";*/ }
    int xx;
    long yy;
    char str[1024];
};
int main()
{
   struct timeval start, end;
   long secs_used,micros_used;
    printf("##### Test conventional ptr ######\n");
    gettimeofday(&start, NULL);
    for (uint64_t i = 0; i < 1000000000; i++) {
      Foo* f = new Foo();
      int xxx = f->xx;
      long yyy = f->yy;
      delete f;
    }
    gettimeofday(&end, NULL);

    printf("start: %d secs, %d usecs\n",start.tv_sec,start.tv_usec);
    printf("end: %d secs, %d usecs\n",end.tv_sec,end.tv_usec);

    secs_used=(end.tv_sec - start.tv_sec); //avoid overflow by subtracting first
    micros_used= ((secs_used*1000000) + end.tv_usec) - (start.tv_usec);

    printf("micros_used for conventional ptr: %d\n",micros_used);

    printf("##### Test Unique Smart ptr ######\n");

    gettimeofday(&start, NULL);
    for (uint64_t i = 0; i < 1000000000; i++) {
      std::unique_ptr<Foo> fu (new Foo());
      int xxx = fu->xx;
      long yyy = fu->yy;
    }
    gettimeofday(&end, NULL);

    printf("start: %d secs, %d usecs\n",start.tv_sec,start.tv_usec);
    printf("end: %d secs, %d usecs\n",end.tv_sec,end.tv_usec);

    secs_used=(end.tv_sec - start.tv_sec); //avoid overflow by subtracting first
    micros_used= ((secs_used*1000000) + end.tv_usec) - (start.tv_usec);

    printf("micros_used for unique ptr: %d\n",micros_used);

    printf("##### Test Shared Smart ptr ######\n");
    gettimeofday(&start, NULL);
    for (uint64_t i = 0; i < 1000000000; i++) {
      std::shared_ptr<Foo> fs (new Foo());
      int xxx = fs->xx;
      long yyy = fs->yy;
    }
    gettimeofday(&end, NULL);

    printf("start: %d secs, %d usecs\n",start.tv_sec,start.tv_usec);
    printf("end: %d secs, %d usecs\n",end.tv_sec,end.tv_usec);

    secs_used=(end.tv_sec - start.tv_sec); //avoid overflow by subtracting first
    micros_used= ((secs_used*1000000) + end.tv_usec) - (start.tv_usec);

    printf("micros_used for shared ptr: %d\n",micros_used);
    std::cout <<"Existing..\n";
    return 0;
}



So, my guess is, the heavy use of these smart pointers in the Ceph IO path is bringing iops/core down substantially.
My suggestion is *not to introduce* any smart pointers in the objectstore interface.

Thanks & Regards
Somnath

-----Original Message-----
From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-owner@vger.kernel.org] On Behalf Of Somnath Roy
Sent: Wednesday, December 02, 2015 4:18 PM
To: Sage Weil (sage@newdream.net); Samuel Just (sam.just@inktank.com)
Cc: ceph-devel@vger.kernel.org
Subject: queue_transaction interface + unique_ptr

Hi Sage/Sam,
As discussed in today's performance meeting , I am planning to change the queue_transactions() interface to the following.

  int queue_transactions(Sequencer *osr, list<TransactionRef>& tls,
                         Context *onreadable, Context *ondisk=0,
                         Context *onreadable_sync=0,
                         TrackedOpRef op = TrackedOpRef(),
                         ThreadPool::TPHandle *handle = NULL) ;

typedef unique_ptr<Transaction> TransactionRef;


IMO , there is a problem with this approach.

The interface like apply_transaction(), queue_transaction() etc. basically the interfaces taking single transaction pointer and internally forming a list to call the queue_transactions() also needs to be changed to accept TransactionRef which will be *bad*. The reason is while preparing list internally we need to move the uniqueue_ptr and callers won't be aware of that.

Also, now changing every interfaces (and callers) that is taking Transaction* will produce a very big delta (and big testing effort as well). 

So, should we *reconsider* co-existing both  queue_transactions() interfaces and call the new one from the IO path ?

Thanks & Regards
Somnath



--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" in the body of a message to majordomo@vger.kernel.org More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" in the body of a message to majordomo@vger.kernel.org More majordomo info at  http://vger.kernel.org/majordomo-info.html
