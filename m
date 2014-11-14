From: scan-admin@coverity.com
Subject: New Defects reported by Coverity Scan for ceph
Date: Fri, 14 Nov 2014 06:21:50 -0800
Message-ID: <54660ffe93e48_254aa9733843444@scan.coverity.com.mail>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from scanrelay.coverity.com ([209.249.196.67]:51898 "EHLO
	scanrelay.coverity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754511AbaKNOVv (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 14 Nov 2014 09:21:51 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org


Hi,

Please find the latest report on new defect(s) introduced to ceph found with Coverity Scan.

8 new defect(s) introduced to ceph found with Coverity Scan.


New defect(s) Reported-by: Coverity Scan
Showing 8 of 8 defect(s)


** CID 1254376:  Resource leak  (RESOURCE_LEAK)
/test/msgr/test_async_driver.cc: 212 in EventDriverTest_NetworkSocketTest_Test::TestBody()()
/test/msgr/test_async_driver.cc: 219 in EventDriverTest_NetworkSocketTest_Test::TestBody()()
/test/msgr/test_async_driver.cc: 220 in EventDriverTest_NetworkSocketTest_Test::TestBody()()
/test/msgr/test_async_driver.cc: 230 in EventDriverTest_NetworkSocketTest_Test::TestBody()()
/test/msgr/test_async_driver.cc: 231 in EventDriverTest_NetworkSocketTest_Test::TestBody()()
/test/msgr/test_async_driver.cc: 227 in EventDriverTest_NetworkSocketTest_Test::TestBody()()
/test/msgr/test_async_driver.cc: 233 in EventDriverTest_NetworkSocketTest_Test::TestBody()()
/test/msgr/test_async_driver.cc: 210 in EventDriverTest_NetworkSocketTest_Test::TestBody()()

** CID 1254374:  Argument cannot be negative  (NEGATIVE_RETURNS)
/test/msgr/test_async_driver.cc: 147 in echoclient(void *)()

** CID 1254375:  Resource leak  (RESOURCE_LEAK)
/test/msgr/test_async_driver.cc: 169 in EventDriverTest_NetworkSocketTest_Test::TestBody()()
/test/msgr/test_async_driver.cc: 166 in EventDriverTest_NetworkSocketTest_Test::TestBody()()
/test/msgr/test_async_driver.cc: 171 in EventDriverTest_NetworkSocketTest_Test::TestBody()()
/test/msgr/test_async_driver.cc: 185 in EventDriverTest_NetworkSocketTest_Test::TestBody()()
/test/msgr/test_async_driver.cc: 187 in EventDriverTest_NetworkSocketTest_Test::TestBody()()
/test/msgr/test_async_driver.cc: 194 in EventDriverTest_NetworkSocketTest_Test::TestBody()()
/test/msgr/test_async_driver.cc: 196 in EventDriverTest_NetworkSocketTest_Test::TestBody()()
/test/msgr/test_async_driver.cc: 201 in EventDriverTest_NetworkSocketTest_Test::TestBody()()
/test/msgr/test_async_driver.cc: 205 in EventDriverTest_NetworkSocketTest_Test::TestBody()()
/test/msgr/test_async_driver.cc: 206 in EventDriverTest_NetworkSocketTest_Test::TestBody()()
/test/msgr/test_async_driver.cc: 210 in EventDriverTest_NetworkSocketTest_Test::TestBody()()
/test/msgr/test_async_driver.cc: 212 in EventDriverTest_NetworkSocketTest_Test::TestBody()()
/test/msgr/test_async_driver.cc: 219 in EventDriverTest_NetworkSocketTest_Test::TestBody()()
/test/msgr/test_async_driver.cc: 220 in EventDriverTest_NetworkSocketTest_Test::TestBody()()
/test/msgr/test_async_driver.cc: 227 in EventDriverTest_NetworkSocketTest_Test::TestBody()()
/test/msgr/test_async_driver.cc: 230 in EventDriverTest_NetworkSocketTest_Test::TestBody()()
/test/msgr/test_async_driver.cc: 231 in EventDriverTest_NetworkSocketTest_Test::TestBody()()
/test/msgr/test_async_driver.cc: 233 in EventDriverTest_NetworkSocketTest_Test::TestBody()()

** CID 1254380:  Uninitialized scalar variable  (UNINIT)
/test/msgr/test_async_driver.cc: 147 in echoclient(void *)()

** CID 1254379:  Uninitialized scalar variable  (UNINIT)
/test/msgr/test_async_driver.cc: 116 in EventDriverTest_PipeTest_Test::TestBody()()

** CID 1254381:  Uninitialized scalar field  (UNINIT_CTOR)
/msg/async/EventSelect.h: 34 in SelectDriver::SelectDriver(CephContext *)()

** CID 1254377:  String not null terminated  (STRING_NULL)
/test/msgr/test_async_driver.cc: 232 in EventDriverTest_NetworkSocketTest_Test::TestBody()()

** CID 1254378:  Uncaught exception  (UNCAUGHT_EXCEPT)
/test/msgr/test_async_driver.cc: 269 in main()
/test/msgr/test_async_driver.cc: 269 in main()


________________________________________________________________________________________________________
*** CID 1254376:  Resource leak  (RESOURCE_LEAK)
/test/msgr/test_async_driver.cc: 212 in EventDriverTest_NetworkSocketTest_Test::TestBody()()
206       ASSERT_EQ(fired_events[0].fd, listen_sd);
207     
208       fired_events.clear();
209       int client_sd = ::accept(listen_sd, NULL, NULL);
210       ASSERT_TRUE(client_sd > 0);
211       r = driver->add_event(client_sd, EVENT_NONE, EVENT_READABLE);
>>>     CID 1254376:  Resource leak  (RESOURCE_LEAK)
>>>     Handle variable "client_sd" going out of scope leaks the handle.
212       ASSERT_EQ(r, 0);
213     
214       do {
215         fired_events.clear();
216         tv.tv_sec = 5;
217         tv.tv_usec = 0;
/test/msgr/test_async_driver.cc: 219 in EventDriverTest_NetworkSocketTest_Test::TestBody()()
213     
214       do {
215         fired_events.clear();
216         tv.tv_sec = 5;
217         tv.tv_usec = 0;
218         r = driver->event_wait(fired_events, &tv);
>>>     CID 1254376:  Resource leak  (RESOURCE_LEAK)
>>>     Handle variable "client_sd" going out of scope leaks the handle.
219         ASSERT_EQ(r, 1);
220         ASSERT_EQ(fired_events[0].mask, EVENT_READABLE);
221     
222         fired_events.clear();
223         char data[100];
224         r = ::read(client_sd, data, sizeof(data));
/test/msgr/test_async_driver.cc: 220 in EventDriverTest_NetworkSocketTest_Test::TestBody()()
214       do {
215         fired_events.clear();
216         tv.tv_sec = 5;
217         tv.tv_usec = 0;
218         r = driver->event_wait(fired_events, &tv);
219         ASSERT_EQ(r, 1);
>>>     CID 1254376:  Resource leak  (RESOURCE_LEAK)
>>>     Handle variable "client_sd" going out of scope leaks the handle.
220         ASSERT_EQ(fired_events[0].mask, EVENT_READABLE);
221     
222         fired_events.clear();
223         char data[100];
224         r = ::read(client_sd, data, sizeof(data));
225         if (r == 0)
/test/msgr/test_async_driver.cc: 230 in EventDriverTest_NetworkSocketTest_Test::TestBody()()
224         r = ::read(client_sd, data, sizeof(data));
225         if (r == 0)
226           break;
227         ASSERT_TRUE(r > 0);
228         r = driver->add_event(client_sd, EVENT_READABLE, EVENT_WRITABLE);
229         r = driver->event_wait(fired_events, &tv);
>>>     CID 1254376:  Resource leak  (RESOURCE_LEAK)
>>>     Handle variable "client_sd" going out of scope leaks the handle.
230         ASSERT_EQ(r, 1);
231         ASSERT_EQ(fired_events[0].mask, EVENT_WRITABLE);
232         r = write(client_sd, data, strlen(data));
233         ASSERT_EQ(r, strlen(data));
234         driver->del_event(client_sd, EVENT_READABLE|EVENT_WRITABLE,
235                           EVENT_WRITABLE);
/test/msgr/test_async_driver.cc: 231 in EventDriverTest_NetworkSocketTest_Test::TestBody()()
225         if (r == 0)
226           break;
227         ASSERT_TRUE(r > 0);
228         r = driver->add_event(client_sd, EVENT_READABLE, EVENT_WRITABLE);
229         r = driver->event_wait(fired_events, &tv);
230         ASSERT_EQ(r, 1);
>>>     CID 1254376:  Resource leak  (RESOURCE_LEAK)
>>>     Handle variable "client_sd" going out of scope leaks the handle.
231         ASSERT_EQ(fired_events[0].mask, EVENT_WRITABLE);
232         r = write(client_sd, data, strlen(data));
233         ASSERT_EQ(r, strlen(data));
234         driver->del_event(client_sd, EVENT_READABLE|EVENT_WRITABLE,
235                           EVENT_WRITABLE);
236       } while (1);
/test/msgr/test_async_driver.cc: 227 in EventDriverTest_NetworkSocketTest_Test::TestBody()()
221     
222         fired_events.clear();
223         char data[100];
224         r = ::read(client_sd, data, sizeof(data));
225         if (r == 0)
226           break;
>>>     CID 1254376:  Resource leak  (RESOURCE_LEAK)
>>>     Handle variable "client_sd" going out of scope leaks the handle.
227         ASSERT_TRUE(r > 0);
228         r = driver->add_event(client_sd, EVENT_READABLE, EVENT_WRITABLE);
229         r = driver->event_wait(fired_events, &tv);
230         ASSERT_EQ(r, 1);
231         ASSERT_EQ(fired_events[0].mask, EVENT_WRITABLE);
232         r = write(client_sd, data, strlen(data));
/test/msgr/test_async_driver.cc: 233 in EventDriverTest_NetworkSocketTest_Test::TestBody()()
227         ASSERT_TRUE(r > 0);
228         r = driver->add_event(client_sd, EVENT_READABLE, EVENT_WRITABLE);
229         r = driver->event_wait(fired_events, &tv);
230         ASSERT_EQ(r, 1);
231         ASSERT_EQ(fired_events[0].mask, EVENT_WRITABLE);
232         r = write(client_sd, data, strlen(data));
>>>     CID 1254376:  Resource leak  (RESOURCE_LEAK)
>>>     Handle variable "client_sd" going out of scope leaks the handle.
233         ASSERT_EQ(r, strlen(data));
234         driver->del_event(client_sd, EVENT_READABLE|EVENT_WRITABLE,
235                           EVENT_WRITABLE);
236       } while (1);
237     
238       ::close(client_sd);
/test/msgr/test_async_driver.cc: 210 in EventDriverTest_NetworkSocketTest_Test::TestBody()()
204       r = driver->event_wait(fired_events, &tv);
205       ASSERT_EQ(r, 1);
206       ASSERT_EQ(fired_events[0].fd, listen_sd);
207     
208       fired_events.clear();
209       int client_sd = ::accept(listen_sd, NULL, NULL);
>>>     CID 1254376:  Resource leak  (RESOURCE_LEAK)
>>>     Handle variable "client_sd" going out of scope leaks the handle.
210       ASSERT_TRUE(client_sd > 0);
211       r = driver->add_event(client_sd, EVENT_NONE, EVENT_READABLE);
212       ASSERT_EQ(r, 0);
213     
214       do {
215         fired_events.clear();

________________________________________________________________________________________________________
*** CID 1254374:  Argument cannot be negative  (NEGATIVE_RETURNS)
/test/msgr/test_async_driver.cc: 147 in echoclient(void *)()
141       int connect_sd = ::socket(AF_INET, SOCK_STREAM, 0);
142       struct sockaddr_in sa;
143       sa.sin_family = AF_INET;
144       sa.sin_port = htons(port);
145       char addr[] = "127.0.0.1";
146       int r = inet_aton(addr, &sa.sin_addr);
>>>     CID 1254374:  Argument cannot be negative  (NEGATIVE_RETURNS)
>>>     "connect_sd" is passed to a parameter that cannot be negative.
147       r = connect(connect_sd, (struct sockaddr*)&sa, sizeof(sa));
148       int t = 0;
149     
150       do {
151         char c[] = "banner";
152         r = write(connect_sd, c, sizeof(c));

________________________________________________________________________________________________________
*** CID 1254375:  Resource leak  (RESOURCE_LEAK)
/test/msgr/test_async_driver.cc: 169 in EventDriverTest_NetworkSocketTest_Test::TestBody()()
163     
164     TEST_P(EventDriverTest, NetworkSocketTest) {
165       int listen_sd = ::socket(AF_INET, SOCK_STREAM, 0);
166       ASSERT_TRUE(listen_sd > 0);
167       int on = 1;
168       int r = ::setsockopt(listen_sd, SOL_SOCKET, SO_REUSEADDR, &on, sizeof(on));
>>>     CID 1254375:  Resource leak  (RESOURCE_LEAK)
>>>     Handle variable "listen_sd" going out of scope leaks the handle.
169       ASSERT_EQ(r, 0);
170       r = set_nonblock(listen_sd);
171       ASSERT_EQ(r, 0);
172       struct sockaddr_in sa;
173       int port = 0;
174       for (port = 38788; port < 40000; port++) {
/test/msgr/test_async_driver.cc: 166 in EventDriverTest_NetworkSocketTest_Test::TestBody()()
160       ::close(connect_sd);
161       return 0;
162     }
163     
164     TEST_P(EventDriverTest, NetworkSocketTest) {
165       int listen_sd = ::socket(AF_INET, SOCK_STREAM, 0);
>>>     CID 1254375:  Resource leak  (RESOURCE_LEAK)
>>>     Handle variable "listen_sd" going out of scope leaks the handle.
166       ASSERT_TRUE(listen_sd > 0);
167       int on = 1;
168       int r = ::setsockopt(listen_sd, SOL_SOCKET, SO_REUSEADDR, &on, sizeof(on));
169       ASSERT_EQ(r, 0);
170       r = set_nonblock(listen_sd);
171       ASSERT_EQ(r, 0);
/test/msgr/test_async_driver.cc: 171 in EventDriverTest_NetworkSocketTest_Test::TestBody()()
165       int listen_sd = ::socket(AF_INET, SOCK_STREAM, 0);
166       ASSERT_TRUE(listen_sd > 0);
167       int on = 1;
168       int r = ::setsockopt(listen_sd, SOL_SOCKET, SO_REUSEADDR, &on, sizeof(on));
169       ASSERT_EQ(r, 0);
170       r = set_nonblock(listen_sd);
>>>     CID 1254375:  Resource leak  (RESOURCE_LEAK)
>>>     Handle variable "listen_sd" going out of scope leaks the handle.
171       ASSERT_EQ(r, 0);
172       struct sockaddr_in sa;
173       int port = 0;
174       for (port = 38788; port < 40000; port++) {
175         memset(&sa,0,sizeof(sa));
176         sa.sin_family = AF_INET;
/test/msgr/test_async_driver.cc: 185 in EventDriverTest_NetworkSocketTest_Test::TestBody()()
179     
180         r = ::bind(listen_sd, (struct sockaddr *)&sa, sizeof(sa));
181         if (r == 0) {
182           break;
183         }
184       }
>>>     CID 1254375:  Resource leak  (RESOURCE_LEAK)
>>>     Handle variable "listen_sd" going out of scope leaks the handle.
185       ASSERT_EQ(r, 0);
186       r = listen(listen_sd, 511);
187       ASSERT_EQ(r, 0);
188     
189       vector<FiredFileEvent> fired_events;
190       struct timeval tv;
/test/msgr/test_async_driver.cc: 187 in EventDriverTest_NetworkSocketTest_Test::TestBody()()
181         if (r == 0) {
182           break;
183         }
184       }
185       ASSERT_EQ(r, 0);
186       r = listen(listen_sd, 511);
>>>     CID 1254375:  Resource leak  (RESOURCE_LEAK)
>>>     Handle variable "listen_sd" going out of scope leaks the handle.
187       ASSERT_EQ(r, 0);
188     
189       vector<FiredFileEvent> fired_events;
190       struct timeval tv;
191       tv.tv_sec = 0;
192       tv.tv_usec = 1;
/test/msgr/test_async_driver.cc: 194 in EventDriverTest_NetworkSocketTest_Test::TestBody()()
188     
189       vector<FiredFileEvent> fired_events;
190       struct timeval tv;
191       tv.tv_sec = 0;
192       tv.tv_usec = 1;
193       r = driver->add_event(listen_sd, EVENT_NONE, EVENT_READABLE);
>>>     CID 1254375:  Resource leak  (RESOURCE_LEAK)
>>>     Handle variable "listen_sd" going out of scope leaks the handle.
194       ASSERT_EQ(r, 0);
195       r = driver->event_wait(fired_events, &tv);
196       ASSERT_EQ(r, 0);
197     
198       fired_events.clear();
199       pthread_t thread1;
/test/msgr/test_async_driver.cc: 196 in EventDriverTest_NetworkSocketTest_Test::TestBody()()
190       struct timeval tv;
191       tv.tv_sec = 0;
192       tv.tv_usec = 1;
193       r = driver->add_event(listen_sd, EVENT_NONE, EVENT_READABLE);
194       ASSERT_EQ(r, 0);
195       r = driver->event_wait(fired_events, &tv);
>>>     CID 1254375:  Resource leak  (RESOURCE_LEAK)
>>>     Handle variable "listen_sd" going out of scope leaks the handle.
196       ASSERT_EQ(r, 0);
197     
198       fired_events.clear();
199       pthread_t thread1;
200       r = pthread_create(&thread1, NULL, echoclient, (void*)port);
201       ASSERT_EQ(r, 0);
/test/msgr/test_async_driver.cc: 201 in EventDriverTest_NetworkSocketTest_Test::TestBody()()
195       r = driver->event_wait(fired_events, &tv);
196       ASSERT_EQ(r, 0);
197     
198       fired_events.clear();
199       pthread_t thread1;
200       r = pthread_create(&thread1, NULL, echoclient, (void*)port);
>>>     CID 1254375:  Resource leak  (RESOURCE_LEAK)
>>>     Handle variable "listen_sd" going out of scope leaks the handle.
201       ASSERT_EQ(r, 0);
202       tv.tv_sec = 5;
203       tv.tv_usec = 0;
204       r = driver->event_wait(fired_events, &tv);
205       ASSERT_EQ(r, 1);
206       ASSERT_EQ(fired_events[0].fd, listen_sd);
/test/msgr/test_async_driver.cc: 205 in EventDriverTest_NetworkSocketTest_Test::TestBody()()
199       pthread_t thread1;
200       r = pthread_create(&thread1, NULL, echoclient, (void*)port);
201       ASSERT_EQ(r, 0);
202       tv.tv_sec = 5;
203       tv.tv_usec = 0;
204       r = driver->event_wait(fired_events, &tv);
>>>     CID 1254375:  Resource leak  (RESOURCE_LEAK)
>>>     Handle variable "listen_sd" going out of scope leaks the handle.
205       ASSERT_EQ(r, 1);
206       ASSERT_EQ(fired_events[0].fd, listen_sd);
207     
208       fired_events.clear();
209       int client_sd = ::accept(listen_sd, NULL, NULL);
210       ASSERT_TRUE(client_sd > 0);
/test/msgr/test_async_driver.cc: 206 in EventDriverTest_NetworkSocketTest_Test::TestBody()()
200       r = pthread_create(&thread1, NULL, echoclient, (void*)port);
201       ASSERT_EQ(r, 0);
202       tv.tv_sec = 5;
203       tv.tv_usec = 0;
204       r = driver->event_wait(fired_events, &tv);
205       ASSERT_EQ(r, 1);
>>>     CID 1254375:  Resource leak  (RESOURCE_LEAK)
>>>     Handle variable "listen_sd" going out of scope leaks the handle.
206       ASSERT_EQ(fired_events[0].fd, listen_sd);
207     
208       fired_events.clear();
209       int client_sd = ::accept(listen_sd, NULL, NULL);
210       ASSERT_TRUE(client_sd > 0);
211       r = driver->add_event(client_sd, EVENT_NONE, EVENT_READABLE);
/test/msgr/test_async_driver.cc: 210 in EventDriverTest_NetworkSocketTest_Test::TestBody()()
204       r = driver->event_wait(fired_events, &tv);
205       ASSERT_EQ(r, 1);
206       ASSERT_EQ(fired_events[0].fd, listen_sd);
207     
208       fired_events.clear();
209       int client_sd = ::accept(listen_sd, NULL, NULL);
>>>     CID 1254375:  Resource leak  (RESOURCE_LEAK)
>>>     Handle variable "listen_sd" going out of scope leaks the handle.
210       ASSERT_TRUE(client_sd > 0);
211       r = driver->add_event(client_sd, EVENT_NONE, EVENT_READABLE);
212       ASSERT_EQ(r, 0);
213     
214       do {
215         fired_events.clear();
/test/msgr/test_async_driver.cc: 212 in EventDriverTest_NetworkSocketTest_Test::TestBody()()
206       ASSERT_EQ(fired_events[0].fd, listen_sd);
207     
208       fired_events.clear();
209       int client_sd = ::accept(listen_sd, NULL, NULL);
210       ASSERT_TRUE(client_sd > 0);
211       r = driver->add_event(client_sd, EVENT_NONE, EVENT_READABLE);
>>>     CID 1254375:  Resource leak  (RESOURCE_LEAK)
>>>     Handle variable "listen_sd" going out of scope leaks the handle.
212       ASSERT_EQ(r, 0);
213     
214       do {
215         fired_events.clear();
216         tv.tv_sec = 5;
217         tv.tv_usec = 0;
/test/msgr/test_async_driver.cc: 219 in EventDriverTest_NetworkSocketTest_Test::TestBody()()
213     
214       do {
215         fired_events.clear();
216         tv.tv_sec = 5;
217         tv.tv_usec = 0;
218         r = driver->event_wait(fired_events, &tv);
>>>     CID 1254375:  Resource leak  (RESOURCE_LEAK)
>>>     Handle variable "listen_sd" going out of scope leaks the handle.
219         ASSERT_EQ(r, 1);
220         ASSERT_EQ(fired_events[0].mask, EVENT_READABLE);
221     
222         fired_events.clear();
223         char data[100];
224         r = ::read(client_sd, data, sizeof(data));
/test/msgr/test_async_driver.cc: 220 in EventDriverTest_NetworkSocketTest_Test::TestBody()()
214       do {
215         fired_events.clear();
216         tv.tv_sec = 5;
217         tv.tv_usec = 0;
218         r = driver->event_wait(fired_events, &tv);
219         ASSERT_EQ(r, 1);
>>>     CID 1254375:  Resource leak  (RESOURCE_LEAK)
>>>     Handle variable "listen_sd" going out of scope leaks the handle.
220         ASSERT_EQ(fired_events[0].mask, EVENT_READABLE);
221     
222         fired_events.clear();
223         char data[100];
224         r = ::read(client_sd, data, sizeof(data));
225         if (r == 0)
/test/msgr/test_async_driver.cc: 227 in EventDriverTest_NetworkSocketTest_Test::TestBody()()
221     
222         fired_events.clear();
223         char data[100];
224         r = ::read(client_sd, data, sizeof(data));
225         if (r == 0)
226           break;
>>>     CID 1254375:  Resource leak  (RESOURCE_LEAK)
>>>     Handle variable "listen_sd" going out of scope leaks the handle.
227         ASSERT_TRUE(r > 0);
228         r = driver->add_event(client_sd, EVENT_READABLE, EVENT_WRITABLE);
229         r = driver->event_wait(fired_events, &tv);
230         ASSERT_EQ(r, 1);
231         ASSERT_EQ(fired_events[0].mask, EVENT_WRITABLE);
232         r = write(client_sd, data, strlen(data));
/test/msgr/test_async_driver.cc: 230 in EventDriverTest_NetworkSocketTest_Test::TestBody()()
224         r = ::read(client_sd, data, sizeof(data));
225         if (r == 0)
226           break;
227         ASSERT_TRUE(r > 0);
228         r = driver->add_event(client_sd, EVENT_READABLE, EVENT_WRITABLE);
229         r = driver->event_wait(fired_events, &tv);
>>>     CID 1254375:  Resource leak  (RESOURCE_LEAK)
>>>     Handle variable "listen_sd" going out of scope leaks the handle.
230         ASSERT_EQ(r, 1);
231         ASSERT_EQ(fired_events[0].mask, EVENT_WRITABLE);
232         r = write(client_sd, data, strlen(data));
233         ASSERT_EQ(r, strlen(data));
234         driver->del_event(client_sd, EVENT_READABLE|EVENT_WRITABLE,
235                           EVENT_WRITABLE);
/test/msgr/test_async_driver.cc: 231 in EventDriverTest_NetworkSocketTest_Test::TestBody()()
225         if (r == 0)
226           break;
227         ASSERT_TRUE(r > 0);
228         r = driver->add_event(client_sd, EVENT_READABLE, EVENT_WRITABLE);
229         r = driver->event_wait(fired_events, &tv);
230         ASSERT_EQ(r, 1);
>>>     CID 1254375:  Resource leak  (RESOURCE_LEAK)
>>>     Handle variable "listen_sd" going out of scope leaks the handle.
231         ASSERT_EQ(fired_events[0].mask, EVENT_WRITABLE);
232         r = write(client_sd, data, strlen(data));
233         ASSERT_EQ(r, strlen(data));
234         driver->del_event(client_sd, EVENT_READABLE|EVENT_WRITABLE,
235                           EVENT_WRITABLE);
236       } while (1);
/test/msgr/test_async_driver.cc: 233 in EventDriverTest_NetworkSocketTest_Test::TestBody()()
227         ASSERT_TRUE(r > 0);
228         r = driver->add_event(client_sd, EVENT_READABLE, EVENT_WRITABLE);
229         r = driver->event_wait(fired_events, &tv);
230         ASSERT_EQ(r, 1);
231         ASSERT_EQ(fired_events[0].mask, EVENT_WRITABLE);
232         r = write(client_sd, data, strlen(data));
>>>     CID 1254375:  Resource leak  (RESOURCE_LEAK)
>>>     Handle variable "listen_sd" going out of scope leaks the handle.
233         ASSERT_EQ(r, strlen(data));
234         driver->del_event(client_sd, EVENT_READABLE|EVENT_WRITABLE,
235                           EVENT_WRITABLE);
236       } while (1);
237     
238       ::close(client_sd);

________________________________________________________________________________________________________
*** CID 1254380:  Uninitialized scalar variable  (UNINIT)
/test/msgr/test_async_driver.cc: 147 in echoclient(void *)()
141       int connect_sd = ::socket(AF_INET, SOCK_STREAM, 0);
142       struct sockaddr_in sa;
143       sa.sin_family = AF_INET;
144       sa.sin_port = htons(port);
145       char addr[] = "127.0.0.1";
146       int r = inet_aton(addr, &sa.sin_addr);
>>>     CID 1254380:  Uninitialized scalar variable  (UNINIT)
>>>     Using uninitialized value "sa". Field "sa.sin_zero" is uninitialized when calling "connect".
147       r = connect(connect_sd, (struct sockaddr*)&sa, sizeof(sa));
148       int t = 0;
149     
150       do {
151         char c[] = "banner";
152         r = write(connect_sd, c, sizeof(c));

________________________________________________________________________________________________________
*** CID 1254379:  Uninitialized scalar variable  (UNINIT)
/test/msgr/test_async_driver.cc: 116 in EventDriverTest_PipeTest_Test::TestBody()()
110       r = driver->add_event(fds[0], EVENT_NONE, EVENT_READABLE);
111       ASSERT_EQ(r, 0);
112       r = driver->event_wait(fired_events, &tv);
113       ASSERT_EQ(r, 0);
114     
115       char c;
>>>     CID 1254379:  Uninitialized scalar variable  (UNINIT)
>>>     Using uninitialized value "c" when calling "write".
116       r = write(fds[1], &c, sizeof(c));
117       ASSERT_EQ(r, 1);
118       r = driver->event_wait(fired_events, &tv);
119       ASSERT_EQ(r, 1);
120       ASSERT_EQ(fired_events[0].fd, fds[0]);
121     

________________________________________________________________________________________________________
*** CID 1254381:  Uninitialized scalar field  (UNINIT_CTOR)
/msg/async/EventSelect.h: 34 in SelectDriver::SelectDriver(CephContext *)()
28        * FD sets after select(). */
29       fd_set _rfds, _wfds;
30       int max_fd;
31       CephContext *cct;
32     
33      public:
>>>     CID 1254381:  Uninitialized scalar field  (UNINIT_CTOR)
>>>     Non-static class member "max_fd" is not initialized in this constructor nor in any functions that it calls.
34       SelectDriver(CephContext *c): cct(c) {}
35       virtual ~SelectDriver() {}
36     
37       int init(int nevent);
38       int add_event(int fd, int cur_mask, int add_mask);
39       void del_event(int fd, int cur_mask, int del_mask);

________________________________________________________________________________________________________
*** CID 1254377:  String not null terminated  (STRING_NULL)
/test/msgr/test_async_driver.cc: 232 in EventDriverTest_NetworkSocketTest_Test::TestBody()()
226           break;
227         ASSERT_TRUE(r > 0);
228         r = driver->add_event(client_sd, EVENT_READABLE, EVENT_WRITABLE);
229         r = driver->event_wait(fired_events, &tv);
230         ASSERT_EQ(r, 1);
231         ASSERT_EQ(fired_events[0].mask, EVENT_WRITABLE);
>>>     CID 1254377:  String not null terminated  (STRING_NULL)
>>>     Passing unterminated string "data" to "strlen", which expects a null-terminated string.
232         r = write(client_sd, data, strlen(data));
233         ASSERT_EQ(r, strlen(data));
234         driver->del_event(client_sd, EVENT_READABLE|EVENT_WRITABLE,
235                           EVENT_WRITABLE);
236       } while (1);
237     

________________________________________________________________________________________________________
*** CID 1254378:  Uncaught exception  (UNCAUGHT_EXCEPT)
/test/msgr/test_async_driver.cc: 269 in main()
263     // must be defined). This dummy test keeps gtest_main linked in.
264     TEST(DummyTest, ValueParameterizedTestsAreNotSupportedOnThisPlatform) {}
265     
266     #endif
267     
268     
>>>     CID 1254378:  Uncaught exception  (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "ceph::FailedAssertion" is thrown and never caught.
269     int main(int argc, char **argv) {
270       vector<const char*> args;
271       argv_to_vec(argc, (const char **)argv, args);
272     
273       global_init(NULL, args, CEPH_ENTITY_TYPE_CLIENT, CODE_ENVIRONMENT_UTILITY, 0);
274       common_init_finish(g_ceph_context);
/test/msgr/test_async_driver.cc: 269 in main()
263     // must be defined). This dummy test keeps gtest_main linked in.
264     TEST(DummyTest, ValueParameterizedTestsAreNotSupportedOnThisPlatform) {}
265     
266     #endif
267     
268     
>>>     CID 1254378:  Uncaught exception  (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "ceph::FailedAssertion" is thrown and never caught.
269     int main(int argc, char **argv) {
270       vector<const char*> args;
271       argv_to_vec(argc, (const char **)argv, args);
272     
273       global_init(NULL, args, CEPH_ENTITY_TYPE_CLIENT, CODE_ENVIRONMENT_UTILITY, 0);
274       common_init_finish(g_ceph_context);


________________________________________________________________________________________________________
To view the defects in Coverity Scan visit, http://scan.coverity.com/projects/25?tab=overview

To unsubscribe from the email notification for new defects, http://scan5.coverity.com/cgi-bin/unsubscribe.py



